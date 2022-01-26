#!/usr/bin/env sh

docker build -t python3:18.04 -f python3.dockerfile .
docker save -o python3_18_04.tar python3:18.04
scp python3_18_04.tar m2.smu.edu:~/workshops/examples/

