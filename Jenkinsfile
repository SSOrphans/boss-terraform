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
                git branch: 'feature/SSOR-266-Terraform_Infrastructure_Orchestration', url: 'https://github.com/SSOrphans/boss-terraform'
            }
        }
        stage('Terraform Init') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Terraform Init'
                    sh 'terraform init -backend-config=backend.hcl'
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
        always { 
            dir('deployment/base-infrastructure') {
                echo 'Terraform Destroy'
                sh 'terraform destroy -auto-approve'
            }
            cleanWs()
        }
    }
}