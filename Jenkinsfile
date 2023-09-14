pipeline{
  agent {label'docker'}
   triggers { pollSCM('* * * * *') }
  stages{
    stage('vcs'){
      steps{
        git url: 'https://github.com/chaitanyasagile/spring-petclinic.git',
            branch: 'dev'
      }
    }
    stage('deploy'){
        steps{
            sh 'docker image build -t myspc:1.0 .'
            sh  'docker container run -d --name spc -p 4200:8080 myspc:1.0'
        }
    }
  }
}  