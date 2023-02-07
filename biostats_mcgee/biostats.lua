load("singularity")

local img_name      = 'biostats_latest-2023-02-07-858e2914ccfc.sif'
local img_directory = '/hpc/applications/containers/'
local img_path      = pathJoin(img_directory, img_name)

function build_command(cmd)
  local home          = os.getenv("HOME")
  local user_libs     = pathJoin(home, 'R/portal/rocker-images/biostats_0')
  local cmd           = 'singularity exec --nv '
  local cmd_beginning = cmd .. '--env R_LIBS_USER=' .. user_libs.. ' '
  local cmd_ending    = img_path .. ' ' .. cmd
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd_beginning .. cmd_ending .. sh_ending
  local csh_cmd       = cmd_beginning .. cmd_ending .. csh_ending
  set_shell_function(cmd, sh_cmd, csh_cmd)
end

local executables = {
  'python3'
  'R',
  'Rscript',
  'rserver',
  'rstudio-server',
  'fastqc',
  'cutadapt',
  'STAR',
  'STARlong',
  'rsem-bam2readdepth',
  'rsem-get-unique',
  'rsem-run-em',
  'rsem-bam2wig',
  'rsem-gff3-to-gtf',
  'rsem-run-gibbs',
  'rsem-build-read-index',
  'rsem-parse-alignments',
  'rsem-sam-validator',
  'rsem-calculate-credibility-intervals',
  'rsem-plot-model',
  'rsem-scan-for-paired-end-reads',
  'rsem-calculate-expression',
  'rsem-plot-transcript-wiggles',
  'rsem-simulate-reads',
  'rsem-extract-reference-transcripts',
  'rsem-prepare-reference',
  'rsem-synthesis-reference-transcripts',
  'rsem-generate-data-matrix',
  'rsem-preref',
  'rsem-tbam2gbam',
  'rsem-gen-transcript-plots',
  'rsem-refseq-extract-primary-assembly' 
}

for _, executable in ipairs(executables) do
  build_command(executable)
end

