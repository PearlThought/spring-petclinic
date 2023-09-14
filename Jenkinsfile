pipeline {
    agent any
    triggers { pollSCM ('* * * * *') }
    stages {
        stage('vcs') {
            agent { label 'build' }
            steps{
                    git url: 'https://github.com/PearlThought/spring-petclinic.git',
                        branch: 'dev'
            }
        }
        stage('Docker Image Build & Test') {
            agent { label 'build' }
            steps {
                sh 'docker build -t spring .'
                sh 'docker tag spring:latest 751353218916.dkr.ecr.ap-south-1.amazonaws.com/spring:latest'
                sh 'docker push 751353218916.dkr.ecr.ap-south-1.amazonaws.com/spring:latest'
            }
        }
        stage('Deploy through ECS'){
          agent{label 'build'}
          steps{
            sh 'aws ecs register-task-definition --cli-input-json file://ecrtask.json'
            sh 'aws ecs create-service --cluster bittu --service-name my-ecs-service2 --task-definition my-ecs-task --desired-count 2'
          }
        }
      }
}
