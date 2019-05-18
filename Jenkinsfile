pipeline {
  agent { label 'general-build' }
  stages {
    stage('Cloning Git') {
      steps {
        sh 'sudo rm -rf tooploox'
        sh 'git clone https://github.com/jacekhewko/tooploox.git'
      }
    }
    stage('Configuring and Deploying Sentry') {
      steps{
        sh """
        cd tooploox
        sudo cp .env.sample .env
        seckey=\$(sudo docker-compose run --rm sentry config generate-secret-key)
        sudo echo "SENTRY_SECRET_KEY=\$seckey" | sudo tee -a .variables > /dev/null
        sudo echo "N" | sudo docker-compose run --rm sentry upgrade
        sudo docker-compose run --rm sentry createuser --email \$APP_LOGIN --password \$APP_PASS --superuser
        sudo docker-compose up -d
        """
      }
    }
    stage('Building image') {
      steps{
        echo "TO DO"
      }
    }
  }
}