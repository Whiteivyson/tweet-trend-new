pipeline {
    agent {
        node {
            label 'maven'
        }
    }

    environment {
        PATH = "/opt/apache-maven-3.9.9/bin:$PATH"
    }

    stages {
        stage('Build') {
            steps {
                sh 'mvn clean deploy -X' // Skip tests if none exist or failing
            }
        }

        stage('SonarQube Analysis') {
            environment {
                scannerHome = tool 'white-sonar-scanner'
            }
            steps {
                withSonarQubeEnv('white-sonarqube-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/target/*.jar', allowEmptyArchive: true
        }
        failure {
            echo 'Build failed. Please check logs and resolve issues.'
        }
    }
}
