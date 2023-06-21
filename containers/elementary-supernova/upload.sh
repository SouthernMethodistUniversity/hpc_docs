#!/bin/zsh

module="es.lua"

# Get image name and destination directory
img_name=$(grep "img_name" ${module} | head -1 | cut -d\' -f2)
img_directory=$(grep "img_directory" ${module} | head -1 | cut -d\' -f2)

# Upload to M3
rsync -avP ${img_name} m3:${img_directory}

