pipeline {
    agent any

    environment {
        // Docker image name
        IMAGE_NAME = "tejasparab17/casestudy-node-app"
        // GitHub credentials ID from Jenkins
        GIT_CREDENTIALS_ID = 'GitHubToken'
        // Path to private SSH key for server access
        SSH_KEY_PATH = '/var/lib/jenkins/.ssh/devops-server-key'
        // Replace with your actual EC2 instance public IP or hostname
        DEPLOY_SERVER = "65.1.234.177"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: "${GIT_CREDENTIALS_ID}",
                    url: 'https://github.com/Tptejas17/NewDevopsCaseStudy.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "./scripts/build_and_push.sh"
                }
            }
        }

        stage('Deploy to EC2 Server') {
            steps {
                sshagent (credentials: ['SSH_EC2_KEY']) {
                    sh """
                        ssh -o StrictHostKeyChecking=no -i ${SSH_KEY_PATH} ubuntu@${DEPLOY_SERVER} '
                            docker pull ${IMAGE_NAME}:latest &&
                            docker stop app || true &&
                            docker rm app || true &&
                            docker run -d --name app -p 80:3000 ${IMAGE_NAME}:latest
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment successful!'
        }
        failure {
            echo '❌ Something went wrong.'
        }
    }
}

