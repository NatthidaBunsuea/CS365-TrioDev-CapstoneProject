pipeline {
    agent any

    environment {
        IMAGE = "natthidabunsuea/tetris:${BUILD_NUMBER}"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'cd/gitops',
                url: 'https://github.com/NatthidaBunsuea/CS365-TrioDev-CapstoneProject.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'docker',
                        usernameVariable: 'USER',
                        passwordVariable: 'PASS'
                    )
                ]) {
                    sh 'echo $PASS | docker login -u $USER --password-stdin'
                }
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE ./Tetris-V2'
            }
        }

        stage('Push Image') {
            steps {
                sh 'docker push $IMAGE'
            }
        }

        stage('Update Manifest') {
            steps {
                sh """
                sed -i 's|image:.*|image: $IMAGE|g' Kubernetes/deployment.yaml
                """
            }
        }

        stage('Push GitHub') {
            steps {
                withCredentials([
                    string(credentialsId: 'github', variable: 'TOKEN')
                ]) {
                    sh '''
                    git config user.name Jenkins
                    git config user.email jenkins@mail.com

                    git add .
                    git commit -m "Update image ${BUILD_NUMBER}" || true

                    git push https://$TOKEN@github.com/NatthidaBunsuea/CS365-TrioDev-CapstoneProject.git HEAD:cd/gitops
                    '''
                }
            }
        }
    }
}
