## build with

sudo docker build -t jlagrone/ml-verse .

## convert with 

sudo docker run -v /var/run/docker.sock:/var/run/docker.sock -v /home/gjfh119/docker/RStudio:/output quay.io/singularity/docker2singularity -n ml-verse_2.2.3.simg jlagrone/ml-verse:latest
