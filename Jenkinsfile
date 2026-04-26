pipeline {
    agent { label 'devops-agent' }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/Lohith9993/devops-prt.git',
                    branch: 'main'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t prt-nginx:latest .'
            }
        }
        stage('Run Container') {
            steps {
                sh 'docker rm -f prt-app || true'
                sh 'docker run -d --name prt-app -p 8080:80 prt-nginx:latest'
            }
        }
        stage('Verify') {
            steps {
                sh 'docker ps | grep prt-app'
            }
        }
    }
}
