#!/bin/bash
touch -a 
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo yum install -y docker
sudo service docker start
sudo docker pull mongo
docker run -dp 27017:27017 --name my-mongodb-tp1 \
    -e MONGO_INITDB_DATABASE=bookAPI \
    mongo 