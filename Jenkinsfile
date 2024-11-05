pipeline {
    agent any
    stages {
        stage('Login to Docker') {
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
       stage('Build Docker Image') {
            steps {
                dir('opt/status-page') {
                    script {
                        def tag = new Date().format("yyyy-MM-dd")
                        sh "docker build -t itayshlanger/status-page-prod:latest ."
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    def tag = new Date().format("yyyy-MM-dd")
                    sh "docker push itayshlanger/status-page-prod:latest"
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

