pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    environment {
        SONAR_HOST_URL = 'http://43.205.231.251:9000'
        SONAR_TOKEN = credentials('sonar-token')
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Checking out code..."
            }
        }

        stage('Build') {
            steps {
                dir('app/demo-app') {
                    sh 'mvn clean install -Dmaven.test.skip=true'
                }
            }
        }

        stage('SonarQube Scan') {
            steps {
                dir('app/demo-app') {
                    withSonarQubeEnv('sonarqube') {
                        sh 'mvn sonar:sonar -Dsonar.projectKey=devsecops'
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('app/demo-app') {
                    sh 'docker build -t demo-app .'
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                echo "Scanning Docker image with Trivy..."
                sh '''
                    trivy image --severity HIGH,CRITICAL --exit-code 1 demo-app:latest
                '''
            }
        }

        stage('ECR Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region ap-south-1

                        aws ecr get-login-password --region ap-south-1 \
                        | docker login --username AWS --password-stdin 742820980479.dkr.ecr.ap-south-1.amazonaws.com
                    '''
                }
            }
        }

        stage('Push to ECR') {
            steps {
                sh '''
                    docker tag demo-app:latest 742820980479.dkr.ecr.ap-south-1.amazonaws.com/demo-app:latest
                    docker push 742820980479.dkr.ecr.ap-south-1.amazonaws.com/demo-app:latest
                '''
            }
        }
    }
}
