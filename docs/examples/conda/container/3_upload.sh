#!/bin/zsh

# Upload to M3
rsync -avP *.sif m3:"\$WORK\containers"

