#!/bin/bash

set -xe

MASTER_URL=$1
NODE_NAME=$2

# Download CLI jar from the master
sudo curl http://${MASTER_URL}:8080/jnlpJars/jenkins-cli.jar -o /tmp/jenkins-cli.jar
sudo curl http://${MASTER_URL}:8080/jnlpJars/slave.jar -o /tmp/slave.jar

# Create node according to parameters passed in
cat <<EOF | sudo java -jar /tmp/jenkins-cli.jar -s "http://${MASTER_URL}:8080" create-node "${NODE_NAME}" |true
<slave>
  <name>${NODE_NAME}</name>
  <description></description>
  <remoteFS>/home/jenkins/agent</remoteFS>
  <numExecutors>1</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher">
    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>
  </launcher>
  <label></label>
  <nodeProperties/>
  <userId>${USER}</userId>
</slave>
EOF

# Run jnlp launcher
sudo java -jar /tmp/slave.jar -jnlpUrl http://${MASTER_URL}:8080/computer/${NODE_NAME}/slave-agent.jnlp