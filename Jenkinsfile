pipeline {
    agent any

    environment {
        DOCKER_HUB_REPO = "azeemakhanum/flask-hello-world"
        CONTAINER_NAME = "flask-hello-world"
    }

    stages {
        // No explicit checkout stage needed when using Pipeline from SCM

        stage('Build') {
            steps {
                echo '🔨 Building Docker image...'
                bat "docker image build -t %DOCKER_HUB_REPO%:latest ."
            }
        }

        stage('Test') {
            steps {
                echo '🧪 Running tests...'
                bat "docker stop %CONTAINER_NAME% || exit 0"
                bat "docker rm %CONTAINER_NAME% || exit 0"
                // Use sh inside docker container because your image is Linux-based
                bat "docker run --name %CONTAINER_NAME% %DOCKER_HUB_REPO% sh -c \"pytest test.py && flake8\""
            }
        }

        stage('Deploy') {
            steps {
                echo '🚀 Deploying Flask app...'
                bat "docker stop %CONTAINER_NAME% || exit 0"
                bat "docker rm %CONTAINER_NAME% || exit 0"
                bat "docker run -d -p 5000:5000 --name %CONTAINER_NAME% %DOCKER_HUB_REPO%"
            }
        }
    }
}
