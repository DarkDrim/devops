pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
        registry = "drim/devops"
        registryCredential = 'dockerhub'
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
         stage('Clone repository') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build docker image') {
            steps {
                script{
                    app = docker.build(registry)
                }
            }
        }

        stage('Push docker image') {
            steps {
                script{
                    docker.withRegistry('', registryCredential) {
                        app.push("latest")
                    }
                }
            }
        }

        stage('Remove Unused docker image') {
            steps{
                sh "docker rmi $registry"
            }
        }
    }
}
