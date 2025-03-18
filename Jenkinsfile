def registry = 'https://trialr471xd.jfrog.io/'

def imageName = 'trialr471xd.jfrog.io/valaxy-docker-local//ttrend'
def version   = '2.1.2'

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
        
       
        stage ("Sonar Analysis") {
            environment {
               scannerHome = tool 'sonar-scanner'  //scanner name configured for slave 
            }
            steps {
                echo '<--------------- Sonar Analysis started  --------------->'
                withSonarQubeEnv('sonarqube-server') {    
                    //sonarqube server name in master
                    sh "${scannerHome}/bin/sonar-scanner"
                }    
                echo '<--------------- Sonar Analysis stopped  --------------->'
            }   
        }
             
        stage("Jar Publish") {
            steps {
                script {
                        echo '<--------------- Jar Publish Started --------------->'
                        def server = Artifactory.newServer url:registry+"/artifactory" ,  credentialsId:"jfrogcreds"
                        def properties = "buildid=${env.BUILD_ID},commitid=${GIT_COMMIT}";
                        def uploadSpec = """{
                            "files": [
                                {
                                "pattern": "jarstaging/(*)",
                                "target": "tttrend-libs-release-local/{1}",
                                "flat": "false",
                                "props" : "${properties}",
                                "exclusions": [ "*.sha1", "*.md5"]
                                }
                            ]
                        }"""
                        def buildInfo = server.upload(uploadSpec)
                        buildInfo.env.collect()
                        server.publishBuildInfo(buildInfo)
                        echo '<--------------- Jar Publish Ended --------------->'  
            }
        }   
    } 

        stage(" Docker Build ") {
            steps {
                script {
                echo '<--------------- Docker Build Started --------------->'
                app = docker.build(imageName+":"+version)
                echo '<--------------- Docker Build Ends --------------->'
                }
            }
            }

        stage (" Docker Publish "){
            steps {
                    script {
                    echo '<--------------- Docker Publish Started --------------->'  
                        docker.withRegistry(registry, 'jfrogcreds'){
                            app.push()
                        }    
                    echo '<--------------- Docker Publish Ended --------------->'  
                    }
                }
        }  
    }
}
