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
        dir('deployment/base-infrastructure') {
            stage('Terraform Init') {
                steps {
                    echo 'Terraform Init'
                    sh 'terraform init -backend-config=./backends/ohio.hcl'
                }
            }
            stage('Terraform Apply') {
                steps {
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
