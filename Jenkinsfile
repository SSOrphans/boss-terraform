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
                git branch: 'afs-demo', url: 'https://github.com/SSOrphans/boss-terraform'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Terraform Init'
                    sh 'terraform init -backend-config=./backends/ohio.hcl'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Terraform Apply'
                    sh 'terraform apply -var-file=./region-inputs/ohio.tfvars -auto-approve'
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
