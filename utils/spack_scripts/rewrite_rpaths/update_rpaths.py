import argparse # for command line input options
import pathlib # for file path features
import os # so we can get current directory and other system things
import sys # for exit
import io # for buffers
import subprocess # for running commands
import shlex # for parsing out terminal commands
from datetime import datetime # to get current date and time

def get_rpath(pkg):
  command_base = 'patchelf --print-rpath '
  command = command_base + pkg
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE)

  rpath_str = ''
  while (True):
    line = proc.stdout.readline()
    if (line == ""): break
    else:
      rpath_str = line.strip()

  return rpath_str

def set_rpath(pkg, rpath, verbose=False):
  command_base = 'patchelf --set-rpath '
  command = command_base + rpath + ' ' + pkg
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE)

  if verbose:
    print(proc)

def get_needed_libs(pkg):
  command_base = 'patchelf --print-needed '
  command = command_base + pkg
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE)

  needs = []
  while (True):
    line = proc.stdout.readline()
    if (line == ""): break
    else:
      needs.append(line.strip())

  return needs

def get_new_lib_path(lib, prefix):
  for subdir, dirs, files in os.walk(prefix):
    for file in files:
      if str(file) == str(lib):
        f = prefix.joinpath(subdir).joinpath(file)
        return f

  return ''

# Set up command line options
parser = argparse.ArgumentParser(
    description='Update rpaths for package dependents in a specified list.')
parser.add_argument('-i', '--packagepaths',
                    help="File with package(s) to update (1 per line)",
                    type=pathlib.Path)
parser.add_argument('-o', '--outfile',
                    help="File to save output to (defaults to rpath_update_{date}.json)",
                    type=pathlib.Path)
parser.add_argument('-v', '--verbose',
                    help="output debugging information",
                    default=False, action='store_true')
parser.add_argument('-n', '--newpath',
                    help="Prefix for the new library path",
                    type=pathlib.Path)
parser.add_argument( '--oldpath',
                    help="Prefix for the old library path to update",
                    type=pathlib.Path)


# parse the input
args = parser.parse_args()

if args.newpath is None:
  print("No prefix specified to update rpaths specified")
  parser.print_help()
  sys.exit(-1)
else:
  prefix = args.newpath

if args.packagepaths is None:
  print("No file with packages to update specified")
  parser.print_help()
  sys.exit(-1)
else:
  pkg_file = args.packagepaths

if args.oldpath is None:
  print("No old prefix specified")
  parser.print_help()
  sys.exit(-1)
else:
  old_prefix = args.oldpath

# read in package locations
with open(pkg_file, 'r') as f:
  pkg_paths = f.readlines()
  for i in range(0, len(pkg_paths)):
    pkg_paths[i] = pkg_paths[i].strip()

if args.verbose:
  print("pkg_paths: \n", pkg_paths)

# loop over the packages to update
for p in pkg_paths:

  # get the rpath and needed libs for the current package
  cur_rpath = get_rpath(p)
  cur_needs = get_needed_libs(p)

  if args.verbose:
    print("cur_rpath: \n", cur_rpath)
    print("cur_needs: \n", cur_needs)

  # check to see if one of the needed libs is in the new path
  #update_list = []
  #for need in cur_needs:
  #  need_path = get_new_lib_path(need, prefix)
  #  if need_path:
  #    tmp = [need, need_path]
  #    update_list.append(tmp)
  #
  #if args.verbose:
  #  print("update_list: \n", update_list)

  # generate a new rpath
  old_str = str(old_prefix).strip()
  if old_str[-1] != os.sep:
    old_str = old_str + os.sep

  new_str = str(prefix).strip()
  if new_str[-1] != os.sep:
    new_str = new_str + os.sep

  new_rpath = cur_rpath.replace(old_str, new_str)

  if args.verbose:
    print("new_rpath: \n", new_rpath)

  # set new rpath
  set_rpath(p, new_rpath)

  if args.verbose:
    tmp_rpath = get_rpath(p)
    print("set new_rpath: \n", tmp_rpath)
