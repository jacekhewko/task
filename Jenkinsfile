pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        sh 'cd /'
        sh 'sudo rm -rf tooploox'
        sh 'git clone https://github.com/jacekhewko/tooploox.git'
      }
    }
    stage('Building image') {
      steps{
        sh """
        cd tooploox
        pwd
        sudo su -
        sudo service docker restart
        echo 'y' | sudo docker system prune
        sudo docker-compose up -d && seckey=\$(sudo docker-compose run --rm sentry config generate-secret-key) && sudo echo "SENTRY_SECRET_KEY=\$seckey" | sudo tee -a .variables > /dev/null && echo "Y jacek.hewko@gmail.com testpass testpass y" | sudo docker-compose run --rm sentry upgrade
        """
      }
    }
    stage('Deploy Image') {
      steps{
        echo "test"
      }
    }
    stage('Remove Unused docker image') {
      steps{
        echo "test"
      }
    }
  }
}
