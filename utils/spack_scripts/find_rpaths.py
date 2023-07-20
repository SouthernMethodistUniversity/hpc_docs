import argparse # for command line input options
import pathlib # for file path features
import os # so we can get current directory and other system things
import sys # for exit
import io # for buffers
import subprocess # for running commands
import shlex # for parsing out terminal commands

def get_spack_dep_hashes(pkg):
  command_base = 'spack dependents --installed '
  command = command_base + pkg
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  if pkg == '/':
   return []

  dep_string = ''
  err=False
  while (True):
    line = proc.stdout.readline()
    if (line == ""): break
    if "No dependents" in line: return []
    if 'Error' in line:
      print('Error:')
      print(proc.stdout)
      err = True
    elif '--' in line:
      continue
    else:
      dep_string = dep_string + line.strip().split(" ")[0] + ' '
      if err:
        print(line)

  if err:
    sys.exit(-1)

  dep_string=" ".join(dep_string.split())
  deps = dep_string.strip().split(" ")
  for i in range(0, len(deps)):
    deps[i] = '/' + deps[i]

  if deps == '/':
   deps = []

  return deps


# Set up command line options
parser = argparse.ArgumentParser(
    description='Find rpaths that depend on specified spack module.')
parser.add_argument('package', metavar='pkg', nargs='+',
                    help="Spack package to search for")
parser.add_argument('-o', '--outfile',
                    help="Send output to the specified file instead of screen",
                    type=pathlib.Path)

# parse the input
args = parser.parse_args()

if args.package is None:
  print("No package specified")
  parser.print_help()
  sys.exit(-1)
else:
  pkg = ''
  for p in args.package:
    pkg = pkg + p + ' '

# get the dependencies
deps = get_spack_dep_hashes(pkg)

# recursively check dependencies
deps_to_check = deps
checked_deps = []

while len(deps_to_check) > 0:
  tmp_deps = get_spack_dep_hashes(deps_to_check[0])
  checked_deps.append(deps_to_check[0])
  deps = deps + list(set(tmp_deps) - set(deps))
  deps_to_check = list(set(deps) - set(checked_deps))

print("deps: ", deps)
