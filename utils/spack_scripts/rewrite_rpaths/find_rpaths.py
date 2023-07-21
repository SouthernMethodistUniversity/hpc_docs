import argparse # for command line input options
import pathlib # for file path features
import os # so we can get current directory and other system things
import sys # for exit
import io # for buffers
import subprocess # for running commands
import shlex # for parsing out terminal commands
from datetime import datetime # to get current date and time

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

def find_prefix(pkg):
  command_base = 'spack find --paths '
  command = command_base + pkg
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

  while (True):
    line = proc.stdout.readline()
    if (line == ""): break
    if '--' in line:
      continue
    else:
      path_string = line.strip().split(" ")[-1]

  return pathlib.Path(path_string)

def check_rpath(file, pkg_prefix):
  command_base = 'chrpath -l '
  command = command_base + str(file)
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  test_str = str(pkg_prefix).strip()
  # make sure path ends with slash
  if test_str[-1] != os.sep:
    test_str = test_str + os.sep
  for line in iter(proc.stdout.readline,''):
    if test_str in line:
      return True

  return False

# Set up command line options
parser = argparse.ArgumentParser(
    description='Find rpaths that depend on specified spack module.')
parser.add_argument('package', metavar='pkg', nargs='+',
                    help="Spack package to search for")
parser.add_argument('-o', '--outfile',
                    help="File to save output to (defaults to pkg_name_{date}_rpath_dependents.txt)",
                    type=pathlib.Path)
parser.add_argument('-v', '--verbose',
                    help="output debugging information",
                    default=False, action='store_true')
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

if args.outfile is None:
  now = datetime.now()
  date_str = now.strftime("%m-%d-%Y_%H:%M:%S")
  outfile = pathlib.Path(str(pkg).strip() + '_' + date_str + '_rpath_dependents.txt')
else:
  outfile = args.outfile

if args.verbose:
  print("outfile: ", outfile)

# get the dependencies
deps = get_spack_dep_hashes(pkg)
pkg_prefix = find_prefix(pkg)
if pkg_prefix.is_symlink():
  pkg_prefix = pkg_prefix.parent.joinpath(pkg_prefix.readlink())
if args.verbose:
  print("path: ", pkg_prefix)

# recursively check dependencies
deps_to_check = deps
checked_deps = []

while len(deps_to_check) > 0:
  tmp_deps = get_spack_dep_hashes(deps_to_check[0])
  checked_deps.append(deps_to_check[0])
  deps = deps + list(set(tmp_deps) - set(deps))
  deps_to_check = list(set(deps) - set(checked_deps))

if args.verbose:
  print("deps: ", deps)

# get dependency paths
dep_paths = deps
for i in range(0, len(deps)):
  dep_paths[i] = find_prefix(deps[i])

if args.verbose:
  print("deps_paths: ", dep_paths)

# check all files in all dependency folders to see if there's an rpath
# TODO / FIXME: can we be smart about this? Are these only in lib and bin dirs?
files_to_update = []
for p in dep_paths:

  if args.verbose:
    print("Checking: ", p)

  # loop over all files in current path
  for subdir, dirs, files in os.walk(p):
    for file in files:
      f = p.joinpath(subdir).joinpath(file)
      if args.verbose:
        print("\tchecking :", f)
      if check_rpath(f, pkg_prefix):
        if args.verbose:
          print("\t\t valid")
        files_to_update.append(f)

if args.verbose:
  print("files to update: (", len(files_to_update), ")")

file = open(outfile,'w')
for f in files_to_update:
  file.write(str(f)+"\n")
file.close()

if args.verbose:
  for f in files_to_update:
    print(f)
