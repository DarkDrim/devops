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

        stage('Test'){
            steps {
                 echo 'Future tests..'
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

        stage('Deploy to EKS webserver') {
            withKubeConfig([credentialsId: 'aws', serverUrl: 'https://F9CEB10726ACDEAAD3983AA09D035638.gr7.us-east-1.eks.amazonaws.com']) {
                sh 'kubectl apply -f deployment_app.yml'
            }
        }
    }
}
