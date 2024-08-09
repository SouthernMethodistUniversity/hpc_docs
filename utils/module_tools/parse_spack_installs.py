import argparse # for command line input options
import json # for json files
import pathlib # for file path features
import io # for buffers
import subprocess # for running commands

# Set up command line options
parser = argparse.ArgumentParser(
    description='Generate a software config file from spack.')
parser.add_argument('-o', '--outfile',
                    help="File to save output to (defaults to software.json)",
                    type=pathlib.Path)
# parse the input
args = parser.parse_args()

if args.outfile is None:
  outfile = pathlib.Path('spack_software.csv')
else:
  outfile = args.outfile

# get the full software list from spack
command = "spack list --format version_json"
proc = subprocess.Popen(command.split(), shell=False, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
data, err = proc.communicate()
raw_spack = json.loads(data)
#print(raw_spack)

# get the installed software from spack
command = "spack find --json"
proc = subprocess.Popen(command.split(), shell=False, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
data, err = proc.communicate()
installed_spack = json.loads(data)

# now loop over all installed packages and add homepages
with open('installed_software.txt', 'w') as f:
  for app in installed_spack:
    software_name = app["name"]
    software_version = app["version"]
    software_source = "spack"
    software_website = ""

    # find homepage from full list
    for test_app in raw_spack:
      if test_app["name"] == app["name"]:
        software_website = test_app["homepage"]
        break

    if software_name != "":
      f.write(software_name + ',' + software_version + ',' + software_source + ',' + software_website + '\n') 
