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
        sh "cd tooploox"
        sh "pwd"
        sh "sudo service docker restart"
        sh "echo 'y' | sudo docker system prune"
        sh "sudo docker-compose up -d"
        sh "seckey=\$(sudo docker-compose run --rm sentry config generate-secret-key)"
        sh "echo 'SENTRY_SECRET_KEY=\$seckey' >> .variables"
        sh "echo 'Y jacek.hewko@gmail.com testpass testpass y' | sudo docker-compose run --rm sentry upgrade"
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
