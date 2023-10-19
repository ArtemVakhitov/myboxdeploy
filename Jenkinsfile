pipeline {
    agent {
        docker {
            image 'docker.io/artemvakhitov/myboxdeploy'
            args '-v /var/run/docker.sock:/var/run/docker.sock --privileged'
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
                sh 'docker push artemvakhitov/myboxweb'
            }
        }
        stage ('deploy on prod using docker') {
            steps {
                sh 'ssh-keyscan -H 158.160.13.44 >> ~/.ssh/known_hosts'
                sh '''ssh root@158.160.13.44 << EOF
	docker pull artemvakhitov/myboxweb
	docker run -p 80:80 artemvakhitov/myboxweb
EOF'''
            }
        }
    }
}