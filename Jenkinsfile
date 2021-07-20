pipeline{ 
    environment {
    registry = "samraazeem/nagp_assignment"
    registryCredential = 'docker'
    dockerImage= ''
  }  
   agent any 
   tools{
     maven 'MAVEN'
}
    
options {
skipDefaultCheckout(true)
}
    stages {
        stage("Code Checkout") {
            steps {
                git url: 'https://github.com/samraazeem/microservice-assignment.git'
            }
        }
        stage('Build Stage') {
            steps{
                sh 'mvn install'  
            }
        }
        stage('Testing Stage'){
            steps{
               sh 'mvn test'
            } 
        }
        stage('SonarQube Analysis'){
			steps{
				withSonarQubeEnv('SONAR'){
					sh 'mvn sonar:sonar -Dsonar.projectKey=test -Dsonar.host.url=http://52.249.217.108:9000 -Dsonar.login=b9b1f74acbea553a843f0af694b9aaeb78daa021'
				}
			}
		}
        stage('Build Docker Image') { 
            steps{
                
                /***sh 'docker build -t "samraazeem/maven":$BUILD_NUMBER"" .'
                script {
                    dockerImage= 'samraazeem/maven":$BUILD_NUMBER"'
                }***/
                script {
                    dockerImage= docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push Image to Dockerhub') {
             steps{
                script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                    }
                }
            }
        }
        stage('Run Docker Image'){
            steps{
                sh 'docker rm -f samra-nagp'
                sh 'docker run -d --name samra-nagp -p 80:8080 samraazeem/nagp_assignment:"$BUILD_NUMBER"'
            }
        } 
    }
}