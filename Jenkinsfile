pipeline {
    agent any
    tools {
        terraform 'terraform'
        git 'git'
    }
    stages {
        stage('Git Checkout') {
            steps {
                echo 'Git Checkout'
                git branch: 'dev', url: 'https://github.com/SSOrphans/boss-terraform'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Terraform Init'
                    sh 'terraform init -backend-config=backend-ohio.hcl'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Terraform Apply'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    post { 
        cleanup {
            cleanWs()
        }
    }
}