#!/bin/bash
sudo yum -y install git
sudo yum -y install docker
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo usermod -a -G sudo jenkins
sudo service docker start
sudo service docker enable
sudo sh /tmp/install-plugins.sh $(echo $(cat /tmp/plugins.txt))
sudo service jenkins restart