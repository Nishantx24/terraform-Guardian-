pipeline {
    agent any

    environment {
        INFRACOST_API_KEY = credentials('infracost-api-key')
        TF_IN_AUTOMATION = "true"
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: 'Nishantx24',
                    url: 'https://github.com/Nishantx24/terraform-Guardian-.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('TFLint Init') {
            steps {
                dir('terraform') {
                    sh 'tflint --init'
                }
            }
        }

        stage('TFLint Scan') {
            steps {
                dir('terraform') {
                    sh 'tflint'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Infracost Breakdown') {
            steps {
                dir('terraform') {
                    sh 'infracost breakdown --path .'
                }
            }
        }
    }

    post {
        success {
            echo '[SUCCESS] Build Successful - Terraform + Infracost completed'
        }
        failure {
            echo '[FAILURE] Build Failed - Check logs'
        }
        always {
            cleanWs()
        }
    }
}
