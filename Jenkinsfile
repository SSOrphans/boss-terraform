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
        stage('Base-infrastructure resources') {
            steps {
                dir('deployment/base-infrastructure') {
                    echo 'Init base-infrastructure remote state'
                    sh 'terraform init -backend-config=./backends/ohio.hcl'
                    echo 'Provision base-infrastructure resources'
                    sh 'terraform apply -var-file=./region-inputs/ohio.tfvars -auto-approve'
                }
            }
        }
        stage('ECS resources') {
            steps {
                dir('deployment/ecs') {
                    echo 'Init ECS remote state'
                    sh 'terraform init -backend-config=./backends/ohio.hcl'
                    echo 'Provision ECS resources'
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
