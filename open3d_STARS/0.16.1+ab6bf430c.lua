help([[
Ubuntu 22.04 container for using Open3D and Intel RealSense

]])
whatis("Version: 0.16.1+ab6bf430c")
whatis("Keywords: 3D, Scanning, RealSense, Real, Sense, Open3D, ros")
whatis("URL: http://www.open3d.org/")
whatis("Description: Open3D and Intel RealSense in Ubuntu 22.04 container")

always_load("singularity")

local img_name      = 'open3d_0.16.1+ab6bf430c.sif'
local img_directory = '/hpc/applications/containers/'
local img_path      = pathJoin(img_directory, img_name)

function build_command(app)
  local home          = os.getenv("HOME")
  local cmd           = 'singularity exec --nv ' .. img_path .. ' ' .. app
  local sh_ending     = ' "$@"'
  local csh_ending    = ' $*'
  local sh_cmd        = cmd .. sh_ending
  local csh_cmd       = cmd .. csh_ending
  set_shell_function(app, sh_cmd, csh_cmd)
end

local executables = {
  'python3',
  'open3d',
  'realsense-viewer',
  'rs-align',
  'rs-convert',
  'rs-fw-update',
  'rs-pointcloud',
  'rs-save-to-disk',
  'rs-align-advanced',
  'rs-data-collect',
  'rs-gl',
  'rs-pose',
  'rs-sensor-control',
  'rs-ar-advanced',
  'rs-depth',
  'rs-gl-net',
  'rs-pose-and-image',
  'rs-server',
  'rs-ar-basic',
  'rs-depth-quality',
  'rs-hdr',
  'rs-pose-predict',
  'rs-software-device',
  'rs-benchmark',
  'rs-distance',
  'rs-hello-realsense',
  'rs-post-processing',
  'rs-terminal',
  'rs-callback',
  'rs-embed',
  'rs-measure',
  'rs-record',
  'rs-tracking-and-depth',
  'rs-capture',
  'rs-enumerate-devices',
  'rs-motion',
  'rs-record-playback',
  'rs-trajectory',
  'rs-color',
  'rs-fw-logger',
  'rs-multicam',
  'rs-rosbag-inspector'
}

for _, executable in ipairs(executables) do
  build_command(executable)
end
