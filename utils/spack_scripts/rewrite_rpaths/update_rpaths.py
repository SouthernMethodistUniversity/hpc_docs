import argparse # for command line input options
import pathlib # for file path features
import os # so we can get current directory and other system things
import sys # for exit
import io # for buffers
import subprocess # for running commands
import shlex # for parsing out terminal commands
from datetime import datetime # to get current date and time
import json # for logging
import shutil # for copying files
import tarfile # for compression
import hashlib # for generating hashes (requires python>= 3.10)
import time # for sleep

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
  command_base = 'patchelf --print-rpath '
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

def get_rpath(pkg):
  command_base = 'patchelf --print-rpath '
  command = command_base + str(pkg)
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
  command = command_base + rpath + ' ' + str(pkg)
  run_cmd = shlex.split(command)
  proc = subprocess.Popen(run_cmd, shell=False, text=True, stdout=subprocess.PIPE)

  if verbose:
    print(proc)

def get_needed_libs(pkg):
  command_base = 'patchelf --print-needed '
  command = command_base + str(pkg)
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
    description='Update rpaths for package dependents of a specific spack install package.')
parser.add_argument('package', metavar='pkg', nargs='*', default='invalid',
                    help="Spack package to search for")
parser.add_argument('-o', '--outfile',
                    help="File to save output to (defaults to rpath_update_{date}.json)",
                    type=pathlib.Path)
parser.add_argument('-v', '--verbose',
                    help="output debugging information",
                    default=False, action='store_true')
parser.add_argument('-n', '--newpath',
                    help="Prefix for the new library path",
                    type=pathlib.Path)
parser.add_argument('--dryrun',
                    help="Run and generate all output, but don't actually update any packages",
                    default=False, action='store_true')
parser.add_argument('--restore',
                    help="Location of a tar.gz backup to restore",
                    type=pathlib.Path)
# parse the input
args = parser.parse_args()

# if we're restoring, we don't need to parse most of the args
if args.restore is None:
  update=True
else:
  update=False

if update:
  if args.package == 'invalid':
    print("No package specified")
    parser.print_help()
    sys.exit(-1)
  else:
    pkg = ''
    for p in args.package:
      pkg = pkg + p + ' '

  if args.newpath is None:
    print("No prefix specified to update rpaths specified")
    parser.print_help()
    sys.exit(-1)
  else:
    prefix = args.newpath

now  = datetime.now()
date_str = now.strftime("%m-%d-%Y_%H-%M-%S")
if args.outfile is None:
  if update:
    outfile = pathlib.Path('rpath_update' + '_' + date_str + '.json')
  else:
    outfile = pathlib.Path('rpath_restore' + '_' + date_str + '.json')
else:
  outfile = args.outfile

# update rpaths
if update:
  # get the dependencies
  deps = get_spack_dep_hashes(pkg)
  old_prefix = find_prefix(pkg)
  if old_prefix.is_symlink():
    old_prefix = old_prefix.parent.joinpath(old_prefix.readlink())
  if args.verbose:
    print("path: ", old_prefix)

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
  pkg_paths = []
  for p in dep_paths:

    if args.verbose:
      print("Checking: ", p)

    # loop over all files in current path
    for subdir, dirs, files in os.walk(p):
      for file in files:
        f = p.joinpath(subdir).joinpath(file)
        if args.verbose:
          print("\tchecking :", f)
        if check_rpath(f, old_prefix):
          if args.verbose:
            print("\t\t valid")
          pkg_paths.append(f)

  if args.verbose:
    print("files to update: (", len(pkg_paths), ")")

  # create a folder to save backup versions of packages to
  backup_dir = pathlib.Path("rpath_pkg_backup_" + date_str + "/")
  backup_dir.mkdir(parents=True, exist_ok=True)
  backup_tar = pathlib.Path("rpath_pkg_backup_" + date_str + ".tar.gz")

  if args.verbose:
    print("pkg_paths: \n", pkg_paths)

  # for logging
  packages = []

  # loop over the packages to update
  for p in pkg_paths:

    # get the rpath and needed libs for the current package
    cur_rpath = get_rpath(p)
    # cur_needs = get_needed_libs(p)

    if args.verbose:
      print("cur_rpath: \n", cur_rpath)

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

    # generate hash of path in case theres more than 1 package with the same name
    h=hashlib.shake_128(str(p).encode('utf-8')).hexdigest(4)
    backup_name = str(p.name) + '_' + str(h)

    # store data
    pkg_settings = {
      "path": str(p),
      "backup_name": backup_name,
      "original rpath": cur_rpath,
      "updated rpath": new_rpath,
      "original prefix": str(old_prefix),
      "new prefix": str(prefix)
    }

    packages.append(pkg_settings)

    # save a backup of the package before updating
    backup_file = backup_dir.joinpath(backup_name)
    shutil.copy2(p, backup_file)

    # wait to make sure file was actually copied.
    # shutil appear to run fsync or similar in the background
    wait_time = 0
    while os.stat(p).st_size != os.stat(backup_file).st_size:
      sleep(1)
      wait_time += 1
    if args.verbose:
      print("waited ", wait_time, " seconds for copy")

    # set new rpath
    if not args.dryrun:
      set_rpath(p, new_rpath)

    if args.verbose:
      tmp_rpath = get_rpath(p)
      print("set new_rpath: \n", tmp_rpath)

  log = {
    "input": [
      {
       "package": pkg,
       "verbose": args.verbose,
       "dryrun": args.dryrun,
       "outfile": str(outfile),
       "newpath": str(args.newpath),
       "oldpath": str(old_prefix)
      }
    ],
    "packages": packages
  }

  json_log = json.dumps(log, indent=2)
  with open(outfile, "w") as f:
    f.write(json_log)

  # save a copy of the log in the backup dir so we can use it to
  # restore packages if needed
  backup_config = backup_dir.joinpath('config.json')
  with open(backup_config, "w") as f:
    f.write(json_log)

  # compress backup
  with tarfile.open(backup_tar, "w:gz") as tar:
    tar.add(backup_dir, arcname=os.path.basename(backup_dir))

  # delete the folder
  shutil.rmtree(backup_dir)

# retore backup
else:

  print("restoring backup from: ", args.restore)

  # extract the backup
  backup_dir = pathlib.Path(pathlib.Path(args.restore.stem).stem)
  backup_files = tarfile.open(args.restore)
  if args.verbose:
    print("extracting: \n", backup_files.getnames())
  backup_files.extractall(args.restore.parent)
  backup_files.close()

  # read in config file
  config_file = open(backup_dir.joinpath('config.json'))
  config = json.load(config_file)
  config_file.close()

  # loop over all the entries
  packages=[]
  for package in config["packages"]:
    if args.verbose:
      print("restoring: ", package["path"])

    pkg_settings = {
      "package": package["path"],
      "restored from": str(backup_dir.joinpath(package["backup_name"]))
    }
    packages.append(pkg_settings)

    if not args.dryrun:
      print("removing: ", package["path"])
      os.remove(package["path"])
      shutil.copy2(backup_dir.joinpath(package["backup_name"]), package["path"])

  # delete the extracted folder
  shutil.rmtree(backup_dir)

  log = {
    "input": [
      {
       "backup archive": str(args.restore),
       "verbose": args.verbose,
       "dryrun": args.dryrun,
       "outfile": str(outfile),
      }
    ],
    "packages": packages
  }

  json_log = json.dumps(log, indent=2)
  with open(outfile, "w") as f:
    f.write(json_log)
