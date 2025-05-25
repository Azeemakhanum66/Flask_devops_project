pipeline {
    agent any
    environment {
        DOCKER_HUB_REPO = "azeemakhanum/flask-hello-world"
        CONTAINER_NAME = "flask-hello-world"
        DOCKERHUB_CREDENTIALS=credentials('dockerhub-credentials')
    }
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                bat 'docker image build -t %DOCKER_HUB_REPO%:latest .'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
                bat 'docker stop %CONTAINER_NAME% || echo Container not running'
                bat 'docker rm %CONTAINER_NAME% || echo Container not found'
                bat 'docker run --name %CONTAINER_NAME% %DOCKER_HUB_REPO% /bin/bash -c "pytest test.py && flake8"'
            }
        }
        stage('Push') {
            steps {
                echo 'Pushing image..'
                bat 'echo %DOCKERHUB_CREDENTIALS_PSW% | docker login -u %DOCKERHUB_CREDENTIALS_USR% --password-stdin'
                bat 'docker push %DOCKER_HUB_REPO%:latest'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                bat "C:\\minikube\\minikube.exe" kubectl -- apply -f deployment.yaml
                bat "C:\\minikube\\minikube.exe" kubectl -- apply -f service.yaml
            }
        }
    }
}
