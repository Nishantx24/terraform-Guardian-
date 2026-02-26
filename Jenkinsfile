pipeline {
    agent {
        docker {
            image 'ghcr.io/terraform-linters/tflint:latest'
            args '-u root:root'
        }
    }

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

        stage('Install Terraform & Infracost') {
            steps {
                sh '''
                apt-get update
                apt-get install -y curl unzip

                # Install Terraform
                curl -LO https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
                unzip terraform_1.7.5_linux_amd64.zip
                mv terraform /usr/local/bin/
                chmod +x /usr/local/bin/terraform

                # Install Infracost
                curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
                '''
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
