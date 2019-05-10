pipeline {
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/jacekhewko/tooploox.git'
      }
    }
    stage('Building image') {
      steps{
        sh "docker-compose up -d && seckey=$(docker-compose run --rm sentry config generate-secret-key) && echo "Y jacek.hewko@gmail.com testpass testpass y" | docker-compose run --rm sentry upgrade"
      }
    }
    stage('Deploy Image') {
      steps{
        echo "test"
      }
    }
    stage('Remove Unused docker image') {
        echo "test"
    }
  }
}
