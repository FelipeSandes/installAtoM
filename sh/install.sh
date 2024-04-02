#!/bin/bash

sudo apt update &&

sudo apt install -y git &&

sudo apt install -y apt-transport-https ca-certificates curl software-properties-common &&

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" &&

sudo apt update &&

sudo apt install -y docker-ce &&

sudo systemctl status docker &&

sudo usermod -aG docker $USER &&

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &&

sudo chmod +x /usr/local/bin/docker-compose &&

sudo systemctl restart docker &&

git clone -b stable/2.6.x https://github.com/artefactual/atom.git atom &&

cd atom &&

export COMPOSE_FILE="$PWD/docker/docker-compose.dev.yml"

docker-compose up -d &&

sysctl vm.max_map_count 262144 &&

docker-compose up -d &&

docker-compose exec atom php symfony tools:purge --demo &&

docker-compose exec atom make -C plugins/arDominionPlugin &&

docker-compose restart atom_worker