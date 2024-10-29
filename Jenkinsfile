pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = credentials('Docker-itay') 
        DOCKER_IMAGE = "itayshlanger/status-page"  
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Docker-itay', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        """

                    }
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub using the credentials
                    sh "echo ${DOCKER_HUB_CREDENTIALS_PSW} | docker login -u ${DOCKER_HUB_CREDENTIALS_USR} --password-stdin"
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the image to Docker Hub
                    docker.image("${DOCKER_IMAGE}:latest").push()
                }
            }
        }
    }
    post {
        always {
            // Logout from Docker Hub
            sh 'docker logout'
            // Clean up Docker system to free space
            sh 'docker system prune -f'
            // Delete the workspace to clean up the working environment
            deleteDir()
        }
    }
}
