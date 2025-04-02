pipeline {
    agent any
    environment {
        IMAGE_NAME = "my-docker-image-${env.BUILD_NUMBER}"  // Replace with your desired image name
    }
    stages {
        stage('code checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/semra06/ABC_project1.git'
            }
        }
        stage('code compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('code test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('code package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Check Directory') {
            steps {
                sh 'pwd'      // Print working directory
                sh 'ls -l'    // List files in the current directory
            }
        }
        stage('build docker image') {
            steps {
                sh 'cp target/ABCtechnologies-1.0.war .'
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."
            }
        }
        stage('push docker image') {
            steps {
                withDockerRegistry([credentialsId: "docker-registry-credentials", url: 'https://registry.hub.docker.com']) {
                    sh "docker push my-docker-image:latest"
                }
            }
        }
        stage('deployment') {
            steps {
                sh "docker run -itd -p 8080:8080 --name abc_project_${BUILD_NUMBER} ${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    } // <-- Closing the 'stages' block
} // <-- Closing the 'pipeline' block
