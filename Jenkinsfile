pipeline {
    agent {
        docker {
            image 'docker.io/artemvakhitov/myboxdeploy:4'
            args '-v /var/run/docker.sock:/var/run/docker.sock --privileged -u root'
        }
    }
    stages {
        stage ('git') {
            steps {
                git 'https://github.com/ArtemVakhitov/myboxfuse.git'
            }
        }
        stage ('build') {
            steps {
                sh 'mvn package'
            }
            
        }
        stage ('build & push docker image') {
            environment {
                HOME = "${env.WORKSPACE}"
            }
            steps {
                sh 'docker build -t artemvakhitov/myboxweb .'
                sh 'cat /root/dockersecret | docker login -u artemvakhitov --password-stdin'
                sh 'docker push artemvakhitov/myboxweb'
            }
        }
        stage ('deploy on prod using docker') {
            steps {
                sh '''ssh -T -o StrictHostKeyChecking=no root@158.160.67.159 <<EOF
docker pull artemvakhitov/myboxweb
docker run -d -p 80:8080 artemvakhitov/myboxweb
EOF
'''
            }
        }
    }
}