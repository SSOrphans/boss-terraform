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
                dir('deployment/vpc') {
                    echo 'Terraform Init'
                    sh 'terraform init -backend-config=backend.hcl'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('deployment/vpc') {
                    echo 'Terraform Apply'
                    sh 'terraform apply -var-file=input.tfvars -auto-approve'
                }
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}