load("apptainer")

function build_command(img, cmd)
  local c0  = 'apptainer exec '
  local c1  = ' env -u XDG_RUNTIME_DIR dbus-launch '
  local sh  = ' "$@"'
  local csh = ' $*'
  local c   = c0 .. img .. c1 .. cmd
  local e   = ' 2> /dev/null'
  set_shell_function(cmd, c .. sh .. e, c .. csh .. e)
end

local img_name      = 'almalinux_remote_desktop_1.0.0.sif'
local img_directory = '/hpc/m3/containers/remote_desktop'
local img_path      = pathJoin(img_directory, img_name)

build_command(img_path, 'emacs')


help([[Name: GNU Emacs
Version: 26.1
Website: https://www.gnu.org/software/emacs/

An extensible, customizable, free/libre text editor — and more.
]])