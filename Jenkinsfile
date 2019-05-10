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
        sh "sudo docker-compose up -d"
        sh "seckey=$(docker-compose run --rm sentry config generate-secret-key)"
        sh "echo 'Y jacek.hewko@gmail.com testpass testpass y' | docker-compose run --rm sentry upgrade"
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
