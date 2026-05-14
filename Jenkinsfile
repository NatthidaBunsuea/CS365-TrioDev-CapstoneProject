pipeline {
    agent any

    environment {
        IMAGE = "natthidabunsuea/tetris:${BUILD_NUMBER}"
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {

        stage('Checkout') {
            steps {
                git branch: 'cd/gitops',
                url: 'https://github.com/NatthidaBunsuea/CS365-TrioDev-CapstoneProject.git'
            }
        }

        stage('Check Skip CI') {
    steps {
        script {
            def msg = sh(script: "git log -1 --pretty=%B", returnStdout: true).trim()
            if (msg.contains('[skip ci]')) {
                currentBuild.result = 'SUCCESS'
                error('Skip CI commit from Jenkins')
            }
        }
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

        stage('SonarQube Analysis') {
            steps {
                dir('App/Tetris-V2') {
                    withSonarQubeEnv('SonarQube') {
                        sh '''
                        $SCANNER_HOME/bin/sonar-scanner \
                        -Dsonar.projectKey=tetris-app \
                        -Dsonar.projectName=tetris-app \
                        -Dsonar.sources=src
                        '''
                    }
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: false
                }
            }
        }
        
        stage('Trivy FS Scan') {
    steps {
        sh '''
        trivy fs --severity HIGH,CRITICAL --exit-code 0 ./App/Tetris-V2
        '''
    }
}
        
        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE ./App/Tetris-V2'
            }
        }

        stage('Trivy Image Scan') {
            steps {
                sh '''
                trivy image --severity HIGH,CRITICAL --exit-code 0 $IMAGE
                '''
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

                    git commit -m "Update image ${BUILD_NUMBER} [skip ci]" || true
                    
                    git push https://$TOKEN@github.com/NatthidaBunsuea/CS365-TrioDev-CapstoneProject.git HEAD:cd/gitops
                    '''
                }
            }
        }
    }
}
