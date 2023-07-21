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

print(get_rpath('/users/jlagrone/repos/hpc_docs/utils/spack_scripts/rewrite_rpaths/test_lib.so'))
print(get_needed_libs('/users/jlagrone/repos/hpc_docs/utils/spack_scripts/rewrite_rpaths/test_lib.so'))
