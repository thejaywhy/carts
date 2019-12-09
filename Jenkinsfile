pipeline {
    agent any

    tools {
      maven 'maven-3.6.3'
    }

    environment {
      // We use localhost:5000 to tell docker to use a local registry
      imageName = "localhost:5000/carts"
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                sh 'mvn clean compile' 
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                sh 'mvn test' 
            }
        }
        stage('Docker-Build') {
            steps {
                script {
                    def newImages = docker.build imageName + ":$BUILD_NUMBER"
                    newImages.push()
                    newImages.push('latest')
                }
            }
        }
        stage('Package') {
            steps {
                echo 'Deploying....'
                sh 'mvn -DskipTests package'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true 
            }
        }
    }
}
