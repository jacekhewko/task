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
sudo echo export APP_PASS="${sentry_pass}" | sudo tee -a /etc/profile > /dev/null
sudo echo export APP_LOGIN="${sentry_login}" | sudo tee -a /etc/profile > /dev/null
source /etc/profile
sudo sleep 120
sudo curl http://${jenkins_url}:8080/jnlpJars/jenkins-cli.jar -o /tmp/jenkins-cli.jar
sudo java -jar /tmp/jenkins-cli.jar -s http://${jenkins_url}:8080 create-job tooploox-sentry < /tmp/job.xml
sudo sh /tmp/join-master.sh ${jenkins_url} general-build