#!/bin/bash
touch -a
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo yum install -y docker
sudo service docker start
sudo docker pull ceiko/nodejs-simple-controller:latest

# Temps d'installation de la BDD sur la machine privee (3 minutes)
sleep 2m

sudo docker run -dp 80:80 ceiko/nodejs-simple-controller:latest