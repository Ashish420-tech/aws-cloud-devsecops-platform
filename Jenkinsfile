pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    environment {
        SONAR_HOST_URL = 'http://43.205.231.251:9000'
        SONAR_TOKEN = credentials('sonar-token')

        AWS_REGION = 'ap-south-1'
        ECR_REPO = '742820980479.dkr.ecr.ap-south-1.amazonaws.com/demo-app'
        IMAGE_TAG = "build-${BUILD_NUMBER}"
        IMAGE = "${ECR_REPO}:${IMAGE_TAG}"
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
                    sh '''
                    export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
                    export PATH=$JAVA_HOME/bin:$PATH

                    java -version
                    mvn clean install -Dmaven.test.skip=true
                    '''
                }
            }
        }

        stage('SonarQube Scan') {
            steps {
                dir('app/demo-app') {
                    withSonarQubeEnv('sonarqube') {
                        sh '''
                        export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
                        export PATH=$JAVA_HOME/bin:$PATH

                        mvn sonar:sonar -Dsonar.projectKey=devsecops
                        '''
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: false
                }
            }
        }

        stage('Docker Build') {
            steps {
                dir('app/demo-app') {
                    sh "docker build -t ${IMAGE} ."
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                echo "Scanning Docker image with Trivy..."
                sh "trivy image --severity HIGH,CRITICAL ${IMAGE}"
            }
        }

        stage('ECR Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'aws-creds', usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region ${AWS_REGION}

                        aws ecr get-login-password --region ${AWS_REGION} \
                        | docker login --username AWS --password-stdin 742820980479.dkr.ecr.ap-south-1.amazonaws.com
                    """
                }
            }
        }

        stage('Push to ECR') {
            steps {
                sh "docker push ${IMAGE}"
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    sh """
                        echo "Deploying version: ${IMAGE_TAG}"

                        docker pull ${IMAGE}

                        docker stop demo-app || true
                        docker rm demo-app || true

                        docker run -d -p 8081:8080 --name demo-app ${IMAGE}
                    """
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                script {
                    sh """
                        echo "Deploying to Kubernetes with image: ${IMAGE}"

                        aws eks --region ${AWS_REGION} update-kubeconfig --name devsecops-cluster

                        kubectl set image deployment/demo-app demo-app=${IMAGE}

                        kubectl rollout status deployment/demo-app
                    """
                }
            }
        }
    }
}
