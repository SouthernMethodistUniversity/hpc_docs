#!/usr/bin/env zsh

dep_flag () {
  ids=("${job_id[@]}")
  dependency_flag=""
  if [ "${#ids[@]}" -gt "0" ]; then
    for i in $(seq 1 ${#ids[@]}); do
      ids[i]="$(printf "afterok:%d" ${ids[i]})"
    done
    s="${ids[@]}"
    dependency_flag="--dependency=${s// /,}"
  fi
  echo ${dependency_flag}
}

job_id=()

if [[ ! -d SST-2 ]] || [[ ! -d NeMo ]]; then
  id=($(sbatch 0.sbatch))
  job_id+=(${id[-1]})
fi

if [[ ! -f nemo-22.06.sqsh ]]; then
  id=($(sbatch $(dep_flag) 1.sbatch))
  job_id+=(${id[-1]})
fi

sbatch $(dep_flag) 2.sbatch

