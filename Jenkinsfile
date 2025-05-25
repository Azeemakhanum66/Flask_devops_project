pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "azeemakhanum/flask-hello-world"  // ✅ Your Docker Hub repo
        CONTAINER_NAME = "flask-hello-world"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // ✅ Use the same ID you gave while adding Jenkins credentials
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building Docker Image...'
                sh 'docker image build -t $DOCKER_HUB_REPO:latest .'
            }
        }

        stage('Test') {
            steps {
                echo 'Running Tests...'
                sh 'docker stop $CONTAINER_NAME || true'
                sh 'docker rm $CONTAINER_NAME || true'
                sh 'docker run --name $CONTAINER_NAME $DOCKER_HUB_REPO /bin/bash -c "pytest test.py && flake8"'
            }
        }

        stage('Push') {
            steps {
                echo 'Pushing Docker Image to Docker Hub...'
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                sh 'docker push $DOCKER_HUB_REPO:latest'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes (Minikube)...'
                sh 'minikube kubectl -- apply -f deployment.yaml'
                sh 'minikube kubectl -- apply -f service.yaml'
            }
        }
    }
}
