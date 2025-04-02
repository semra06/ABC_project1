pipeline {
    agent any
    environment {
        IMAGE_NAME = "semra06/my-docker-image"
    }
    stages {
        stage('Code Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/semra06/ABC_project1.git'
            }
        }
        stage('Code Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Code Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Code Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Check Directory') {
            steps {
                sh 'pwd'
                sh 'ls -l'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'cp target/ABCtechnologies-1.0.war .'  
                sh "docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} ."  
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-registry-credentials', url: '']) {
                    sh "docker tag ${IMAGE_NAME}:${env.BUILD_NUMBER} ${IMAGE_NAME}:latest"
                    sh "docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Deployment') {
            steps {
                sh '''
                docker stop abc_project || true
                docker rm abc_project || true
                sh "docker run -itd -p 8181:8080 --name abc_project_${env.BUILD_NUMBER} ${IMAGE_NAME}:${env.BUILD_NUMBER}"
                # Tomcat Cache Temizleme
                docker exec abc_project rm -rf /usr/local/tomcat/work/Catalina/localhost/*
                docker restart abc_project
                '''
            }
        }
    }
}
