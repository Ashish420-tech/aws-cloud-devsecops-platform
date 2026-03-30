pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }

    environment {
        SONAR_HOST_URL = 'http://<your-ec2-ip>:9000'
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
                echo "Running Maven Build..."
                dir('app/demo-app') {
                    sh 'mvn clean install -Dmaven.test.skip=true'
                }
            }
        }

        stage('SonarQube Scan') {
            steps {
                echo "Running SonarQube scan..."
                dir('app/demo-app') {
                    withSonarQubeEnv('sonarqube') {
                        sh 'mvn sonar:sonar -Dsonar.projectKey=devsecops'
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                echo "Skipping Quality Gate for now"
            }
        }
    }
}
