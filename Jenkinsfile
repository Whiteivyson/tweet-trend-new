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

        stage("Unit Test") {
            steps { 
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
                withSonarQubeEnv('sonarqube-server') {
                    sh "${scannerHome}/bin/sonar-scanner"
                }
            }
        }

        stage("Quality Gate") {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate()
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
    }
}
