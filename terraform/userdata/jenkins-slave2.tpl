#!/bin/bash
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk
sudo yum -y install git
sudo yum -y install docker
sudo usermod -aG docker ec2-user
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo service docker start
sudo service docker enable
sudo sleep 240
sudo sh /tmp/join-master.sh ${jenkins_url} specialized-builder