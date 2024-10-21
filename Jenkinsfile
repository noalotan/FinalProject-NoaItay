pipeline {
    agent any

    stages {
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
