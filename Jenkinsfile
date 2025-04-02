pipeline {
    agent any
    environment {
        IMAGE_NAME = "semra06/my-docker-image-${env.BUILD_NUMBER}"  // İmaj adını BUILD_NUMBER ile özelleştirin
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
                sh 'pwd'      // Çalışma dizinini yazdır
                sh 'ls -l'    // Dizin içeriğini listele
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'cp target/ABCtechnologies-1.0.war .'  // WAR dosyasını kopyala
                sh "docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} ."  // İmajı BUILD_NUMBER ile oluştur
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-registry-credentials', url: 'https://registry.hub.docker.com']) {
                    // Docker Hub'a latest tag'ini ve BUILD_NUMBER tag'ini push et
                    sh "docker tag semra06/${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest"
                    sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                    sh "docker push my-docker-image:latest"
                }
            }
        }
        stage('Deployment') {
            steps {
                sh "docker run -itd -p 8080:8080 --name abc_project_${BUILD_NUMBER} ${IMAGE_NAME}:${BUILD_NUMBER}"
            }
        }
    } // <-- Closing the 'stages' block
} // <-- Closing the 'pipeline' block
