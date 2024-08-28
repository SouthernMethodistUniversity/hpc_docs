import pathlib

module_files = list(pathlib.Path('../../modules').rglob('*.lua'))

print(module_files)

with open('installed_software.txt', 'w') as f:
    for mod_file in module_files:
        software_name = ""
        software_version = ""
        software_source = "staff installed"
        software_website = ""
        with open(mod_file) as cur_module:
            Lines = cur_module.readlines()
            for line in Lines:
                if "[[Name:" in line:
                    software_name = line.split(":", 1)[1].strip()
                elif "Version:" in line:
                    software_version = line.split(":", 1)[1].strip()
                elif "Website:" in line:
                    software_website = line.split(":", 1)[1].strip()

            if software_name != "":
                 f.write(software_name + ',' + software_version + ',' + software_source + ',' + software_website + '\n') 