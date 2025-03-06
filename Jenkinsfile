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
        stage("Build") {
            steps {
                 echo "------build test started ------"
                sh 'mvn clean deploy -Dmaven.test.skip=true'
                 echo "------build test completed ------"
            }
        }

        stage("Unit Test"){
            steps{ 
                 echo "------unit test started ------"
                sh 'mvn surefire-report:report'
                 echo "------unit test completed ------"
            }
        }
        stage("Sonar Code Analysis") {
            environment {
                scannerHome = tool 'ttrend-sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonarqube-server') { // If you have multiple global server connections, specify the name here
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage("Quality gate") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    // The waitForQualityGate step waits for the Quality Gate result from SonarQube.
                    // Setting abortPipeline: true means the pipeline will be aborted if the Quality Gate fails.
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
