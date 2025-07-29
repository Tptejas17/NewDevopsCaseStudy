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
                dir('infra') {
        		withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                		sh '''
                		terraform init
                		terraform destroy -auto-approve \
                        	-var "aws_access_key=$AWS_ACCESS_KEY_ID" \
                        	-var "aws_secret_key=$AWS_SECRET_ACCESS_KEY"

                		terraform apply -auto-approve \
                        	-var "aws_access_key=$AWS_ACCESS_KEY_ID" \
                        	-var "aws_secret_key=$AWS_SECRET_ACCESS_KEY"
                        '''
                    }
                }
            }
        }

        stage('Configure EC2 with Ansible') {
            steps {
                dir('ansible') {
                    withCredentials([
                        sshUserPrivateKey(credentialsId: 'ec2-ssh-key', keyFileVariable: 'SSH_KEY'),
                        [$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'aws-creds', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']
                    ]) {
                        script {
                            def publicIp = sh(
                                script: '''
                                    /usr/local/bin/aws ec2 describe-instances --filters "Name=tag:Name,Values=CaseStudyAppInstance" \
                                    --query "Reservations[*].Instances[*].PublicIpAddress" --output text --region ap-south-1
                                ''',
                                returnStdout: true
                            ).trim()

                            writeFile file: 'hosts.ini', text: """
[app_server]
${publicIp} ansible_user=ubuntu ansible_ssh_private_key_file=${SSH_KEY}
"""
                        }

                        sh '''
                            chmod 400 $SSH_KEY
                            ansible-playbook -i hosts.ini deploy.yml --private-key $SSH_KEY
                        '''
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

