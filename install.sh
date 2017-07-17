#!/bin/sh

# install git
sudo apt-get -qqy install git

# install docker and enable access without sudo
sudo curl -sSL https://get.docker.com | sh
sudo gpasswd -a pi docker
newgrp docker

# install docker-compose
sudo chown -R pi /usr/local/bin
sudo apt-get -qqy install python-pip
sudo pip install docker-compose

# clone dockerfiles, build and execute them
git clone https://github.com/wederbn/raspberry-pi-opentosca-dockerfiles.git && cd raspberry-pi-opentosca-dockerfiles
docker-compose build
docker-compose up