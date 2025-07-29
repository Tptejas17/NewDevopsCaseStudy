pipeline {
    agent any

    environment {
        IMAGE = "tejasparab17/casestudy-node-app:latest"
        AWS_DEFAULT_REGION = "ap-south-1"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/Tptejas17/NewDevopsCaseStudy.git', credentialsId: 'GitHubToken'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'chmod +x scripts/build_and_push.sh'
                sh './scripts/build_and_push.sh'
            }
        }

        stage('Provision EC2 with Terraform') {
            steps {
                dir('infra/terraform') {
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                        sh '''
                            terraform init
                            terraform apply -auto-approve
                        '''
                    }
                }
            }
        }

        stage('Configure EC2 with Ansible') {
            steps {
                dir('infra/ansible') {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'KEY')]) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                            sh '''
                                chmod 400 $KEY
                                EC2_IP=$(cd ../terraform && terraform output -raw public_ip)
                                echo "[web]" > inventory
                                echo "$EC2_IP ansible_user=ubuntu ansible_ssh_private_key_file=$KEY" >> inventory

                                ansible-playbook -i inventory playbook.yml
                            '''
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo '✅ Pipeline finished.'
        }
        failure {
            echo '❌ Something went wrong.'
        }
    }
}

