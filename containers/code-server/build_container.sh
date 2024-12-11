#/bin/bash -e
# build singularity container for code-server
# just pull docker image from https://hub.docker.com/r/linuxserver/code-server

# specify version
PLATFORM="amd64"
VERSION="4.11.0"
TAG=${PLATFORM}-${VERSION}

echo "Building tag: ${TAG}"

# build the container
module purge
module load singularity
apptainer build --fakeroot code-server_${TAG}.sif docker://linuxserver/code-server:${TAG}

# move container to /hpc/{sys}/containers/
CLUSTER=$(scontrol show config | grep ClusterName | grep -oP '= \K.+')
if [ "$CLUSTER" = "nvidia" ]; then
  CLUSTER="mp"
fi
mkdir -p /hpc/${CLUSTER}/containers/code-server
mv code-server_${TAG}.sif /hpc/${CLUSTER}/containers/code-server/code-server_${TAG}.sif 

# create a module file in ../../modules/ (in the git repo)
RUN_COMMAND="apptainer run "
if [ "$CLUSTER" = "mp" ]; then
  RUN_COMMAND="apptainer run --nv "
fi

mkdir -p ../../modules/${CLUSTER}/code-server
MODULE_FILE=../../modules/${CLUSTER}/code-server/${VERSION}.lua
(
sed 's/^ \{2\}//' > "$MODULE_FILE" << EOL
  always_load('singularity')
  local sif_file = '/hpc/${CLUSTER}/containers/code-server/code-server_${TAG}.sif'

  local work_dir = '/work'
  local lustre_work = '/lustre/work'
  local scratch_dir = os.getenv("SCRATCH")

  function build_command(app)
    local cmd        = '${RUN_COMMAND} -B ' .. scratch_dir .. ',' .. work_dir .. ',' .. lustre_work .. ' -B $PWD:/host_pwd --pwd /host_pwd ' .. sif_file .. ' ' .. app
    local sh_ending  = ' "$@"'
    local csh_ending = ' $*'
    local sh_cmd     = cmd .. sh_ending
    local csh_cmd    = cmd .. csh_ending
    set_shell_function(app , sh_cmd, csh_cmd)
  end

build_command('code-server')
EOL
)
