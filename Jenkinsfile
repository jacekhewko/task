pipeline {
  agent { label 'general-build' }
  stages {
    stage('Cloning Git') {
      steps {
        sh 'sudo rm -rf tooploox'
        sh 'git clone https://github.com/jacekhewko/tooploox.git'
      }
    }
    stage('Building image') {
      steps{
        sh """
        sudo service docker restart
        cd tooploox
        sudo cp .env.sample .env
        seckey=\$(sudo docker-compose run --rm sentry config generate-secret-key)
        sudo echo "SENTRY_SECRET_KEY=\$seckey" | sudo tee -a .variables > /dev/null
        sudo echo "Y jacek.hewko@gmail.com testpass testpass y" | sudo docker-compose run --rm sentry upgrade
        sudo docker-compose run --rm sentry createuser --email dupa@dupa.pl --password test --superuser
        sudo docker-compose up -d
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
