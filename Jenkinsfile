pipeline {
    agent {
        node {
            label 'maven'
        }
    }
environment{
    PATH = "/opt/apache-maven-3.9.9/bin:$PATH"

}
    stages {
        stage("Build"){
             steps{
                sh 'mvn clean deploy -DskipTests'
            }
        }  


        stage("Sonar Code Analysis") {
            environment {
                scannerHome = tool 'ttrend-sonar-scanner'
            }
            steps{
    withSonarQubeEnv('sonarqube-server') { // If you have configured more than one global server connection, you can specify its name
      sh "${scannerHome}/bin/sonar-scanner"
    }
        }  
    }
}

