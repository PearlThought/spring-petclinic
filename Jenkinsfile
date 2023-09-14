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
            post {
                success {
                    script {
                        def slackCredential = credentials('slack-api-token')
                        slackSend(
                            color: 'good',
                            message: "Build successful for ${env.JOB_NAME} (${env.BUILD_NUMBER})",
                            credentialId: slackCredential
                        )
                    }
                }
                failure {
                    script {
                        def slackCredential = credentials('slack-api-token')
                        slackSend(
                            color: 'danger',
                            message: "Build failed for ${env.JOB_NAME} (${env.BUILD_NUMBER})",
                            credentialId: slackCredential
                        )
                    }
                }
            }
        }
        }       
        stage('Deploy '){
          agent{label 'build'}
          steps{
            sh 'docker container run -d -p 30004:8080 751353218916.dkr.ecr.ap-south-1.amazonaws.com/spring:latest'
          }
          post {
              success {
                  script {
                      def slackCredential = credentials('slack')
                      slackSend(
                          color: 'good',
                          message: "Deployment successful for ${env.JOB_NAME} (${env.BUILD_NUMBER})",
                          credentialId: slackCredential
                      )
                  }
              }
              failure {
                  script {
                      def slackCredential = credentials('slack')
                      slackSend(
                          color: 'danger',
                          message: "Deployment failed for ${env.JOB_NAME} (${env.BUILD_NUMBER})",
                          credentialId: slackCredential
                      )
                  }
              }
          }
        
    }
      
  }

