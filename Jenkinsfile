pipeline {
    agent any

    stages {
        stage('Setup AWS Credentials') {
            steps {
                withCredentials([aws(credentialsId: 'aws credentials')]) {
                    script {
                        env.AWS_ACCESS_KEY_ID = "${AWS_ACCESS_KEY_ID}"
                        env.AWS_SECRET_ACCESS_KEY = "${AWS_SECRET_ACCESS_KEY}"
                    }
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
