pipeline{
  agent {label'docker'}
   triggers { pollSCM('* * * * *') }
  stages{
    stage('vcs'){
      steps{
        git url: 'https://github.com/PearlThought/spring-petclinic.git',
            branch: 'dev'
      }
    }
    stage('build'){
        steps{
            sh './mvnw package'            
        }
    }
    stage('deploy'){
      steps{
        sh 'nohup java -jar target/*.jar &'
      }
    }
  }
}  