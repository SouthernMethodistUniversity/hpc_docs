whatis("AlphaFold3")
family("alphafold")

help([[Name: AlphaFold3
Version: 3.0.4
Website: https://github.com/google-deepmind/alphafold3
License Owners : 

AlphaFold 3 is an advanced artificial intelligence model created by Google DeepMind and Isomorphic Labs that predicts the 3D structures and interactions of all of life's major molecules, going far beyond just proteins.
]])

LmodMessage('Terms of Use:')
LmodMessage('https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md')
LmodMessage('') 
LmodMessage('Usage:')
LmodMessage("run_alphafold.py --json_path=/path/to/fold_input.json  --output_dir=/path/to/af_output")
LmodMessage('')
LmodMessage('Do not set the model_dir or database directory options. These are already set to minimize system load.')

local jobid = os.getenv("SLURM_JOB_ID") or ""

if (jobid == nil or jobid == "") then
    LmodBreak("\nRunning AlphaFold outside of a job is not permitted. Please submit a job.\n")
end

always_load('apptainer')
local container_path="/hpc/m3/containers/alphafold3.sif"
local flags="--nv  -B /hpc/mp/apps/alphafold/alphafold3_models/:/models --mount type=bind,src=/raid/local/datasets/alphafold3_dbs.squashfs,dst=/public_databases,ro,image-src=/ --app"

setenv("APPTAINERENV_JAX_PLATFORMS", "cuda")

function build_command(app, appname)
   local app_command = pathJoin(app_path, app)
   local cmd        = 'apptainer run  ' .. flags .. ' ' .. appname ..  ' '  .. container_path
   local sh_ending  = ' "$@"'
   local csh_ending = ' $*'
   local sh_cmd     = cmd .. sh_ending
   local csh_cmd    = cmd .. csh_ending
   set_shell_function(app, sh_cmd, csh_cmd)
end

build_command("run_alphafold.py", "run_alphafold.py")
