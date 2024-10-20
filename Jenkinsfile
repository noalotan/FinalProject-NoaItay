pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'noa', url: 'https://github.com/noalotan/FinalProject-NoaItay.git'
                dir('eks-terraform') {
                    echo 'Checked out the code'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('eks-terraform') {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up'
        }
        success {
            echo 'Terraform apply succeeded!'
        }
        failure {
            echo 'Terraform apply failed.'
        }
    }
}
