#!/usr/bin/env bash
# Defines a single `ollama()` wrapper for running Ollama on HPC.
# Based on https://github.com/gsbdarc/ollama_helper

ollama() {
  local LOWERPORT=32768 UPPERPORT=60999
  local S PORT_FILE HOST_FILE PORT HOST ENV_HOST BIND

  # require a container name
  if [ -z "$CONTAINER_IMAGE" ]; then
    echo "ERROR: container image not found. Please load an ollama module first" >&2
    return 1
  fi

  # require a job id (except for appmgr)
  CURRENT_USER=$(id -un)
  if [[ -z "$SLURM_JOB_ID" || "$CURRENT_USER" != "appmgr" ]]; then
    echo "ERROR: please run Ollama in a job" >&2
    return 1
  fi

  # Set option location or default to $HOME
  if [ -z "$OLLAMA_BASE_DIR" ]; then
    OLLAMA_BASE_DIR=${HOME}
  fi

  # Prepare your scratch tree for keys, models, host & port
  S="${OLLAMA_BASE_DIR}/ollama"
  mkdir -p "${S}/.ollama"
  if [ -z "$OLLAMA_MODEL_DIR" ]; then
    mkdir -p "${S}/models"
    OLLAMA_MODEL_DIR="${S}/models"
  fi
  if [ -z "$OLLAMA_LOG_DIR" ]; then
    mkdir -p "${S}"/logs
    OLLAMA_LOG_DIR="${S}/logs"
  fi
  PORT_FILE="${OLLAMA_LOG_DIR}/port_${SLURM_JOB_ID}.txt"
  HOST_FILE="${OLLAMA_LOG_DIR}/host_${SLURM_JOB_ID}.txt"

  # 3) Helper to pick an unused TCP port
  find_available_port() {
    local p
    while :; do
      p=$(shuf -i "${LOWERPORT}-${UPPERPORT}" -n1)
      if ! ss -tuln | grep -q ":${p} "; then
        echo "$p"
        return
      fi
    done
  }

  # 4) If first‐time or explicitly "serve", pick & record port+host, then start server
  if [ "$1" = "serve" ] || [ ! -f "$PORT_FILE" ] || [ ! -f "$HOST_FILE" ]; then

    if [ -z "$OLLAMA_PORT" ]; then
      PORT=$(find_available_port)
      echo "$PORT" > "$PORT_FILE"
    else
      PORT=${OLLAMA_PORT}
    fi

    # record the short hostname
    if [ -z "$OLLAMA_HOST" ]; then
      hostname -s > "$HOST_FILE"
    else
      echo ${OLLAMA_HOST} > "$HOST_FILE"
    fi

    # bind on all interfaces
    BIND="0.0.0.0:${PORT}"
    ENV_HOST="http://$(<"$HOST_FILE"):${PORT}"

    echo "Starting Ollama server binding to ${BIND}"
    echo "Advertising server to clients at ${ENV_HOST}"

    # drop the "serve" arg so it isn't passed twice
    shift

    exec apptainer run \
      --nv \
      --env OLLAMA_MODELS="${OLLAMA_MODEL_DIR}" \
      --env OLLAMA_HOST="http://${BIND}" \
      --env OLLAMA_PORT="${PORT}" \
      ${CONTAINER_IMAGE} serve "$@"
  fi

  # 5) Otherwise, act as a client: read recorded host+port and forward command
  PORT=$(<"$PORT_FILE")
  HOST=$(<"$HOST_FILE")
  ENV_HOST="http://${HOST}:${PORT}"

  echo "Forwarding 'ollama $*' to ${ENV_HOST}"

  apptainer run \
    --env OLLAMA_MODELS="${OLLAMA_MODEL_DIR}" \
    --env OLLAMA_HOST="${ENV_HOST}" \
    --env OLLAMA_PORT="${PORT}" \
    ${CONTAINER_IMAGE} "$@"
}

# Export so that subshells (e.g. slurm scripts) will inherit it
export -f ollama
