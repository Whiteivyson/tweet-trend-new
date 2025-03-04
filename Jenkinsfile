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
            steps {
              withSonarQubeEnv('sonarqube-server') {
                sh '''${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=whiteivyson01_ttrend \
                   -Dsonar.projectName=ttrend \
                   -Dsonar.projectVersion=1.0 \
                   -Dsonar.sources=src/ \
                   -Dsonar.java.binaries=target/test-classes/com/visualpathit/account/controllerTest/ \
                   -Dsonar.junit.reportsPath=target/surefire-reports/ \
                   -Dsonar.jacoco.reportsPath=target/jacoco.exec \
                   -Dsonar.java.checkstyle.reportPaths=target/checkstyle-result.xml'''
              }
            }
        }  
    }
}

