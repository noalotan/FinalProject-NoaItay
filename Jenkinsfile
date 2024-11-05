pipeline {
    agent any
    parameters {
        string(name: 'prBranch', defaultValue: '', description: 'The source branch of the PR')
    }
    stages {
        stage('Checkout PR Branch') {
            steps {
                echo "Checking out PR branch: ${params.prBranch}"
                checkout scm: [
                    $class: 'GitSCM',
                    branches: [[name: "origin/${params.prBranch}"]],
                    userRemoteConfigs: [[
                        url: 'https://github.com/noalotan/FinalProject-NoaItay.git',
                        credentialsId: 'git-password' 
                    ]]
                ]
            }
        }
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
                    sh " docker build -t itayshlanger/status-page-dev:latest ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push itayshlanger/status-page-dev:latest"
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
