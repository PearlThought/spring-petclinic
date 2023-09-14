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
                sh 'docker image build -t spc:latest .'
                sh 'docker tag spc:latest public.ecr.aws/u1z2h9e6/spc:latest'
                sh 'docker push public.ecr.aws/u1z2h9e6/spc:latest'
            }
        }
      }
}
