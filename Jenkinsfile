pipeline {
    agent {
        node {
            label 'maven'
        }
    }
    tools {
        maven 'Maven 3.9.9'
        jdk 'Java 17'
    }

environment {
    PATH = "/opt/apache-maven-3.9.9/bin:$PATH"
}
    stages {
       stage("build"){
            steps {
                sh 'mvn clean deploy'
        }
       }
    }
}
