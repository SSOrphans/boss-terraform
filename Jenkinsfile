pipeline {
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
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
