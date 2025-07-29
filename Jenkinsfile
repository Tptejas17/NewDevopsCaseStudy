pipeline {
    agent any

    environment {
        IMAGE_NAME = "tejasparab17/casestudy-node-app:latest"
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
                withCredentials([usernamePassword(credentialsId: 'DockerHubCred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh './scripts/build_and_push.sh'
                }
            }
        }

        stage('Provision EC2 with Terraform') {
            steps {
                dir('terraform') {
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
                dir('ansible') {
                    withCredentials([sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'SSH_KEY')]) {
                        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds']]) {
                            sh '''
                                chmod 400 $SSH_KEY
                                ansible-playbook -i inventory setup.yml --private-key $SSH_KEY
                            '''
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully."
        }
        failure {
            echo "❌ Pipeline failed. Please check logs."
        }
    }
}

