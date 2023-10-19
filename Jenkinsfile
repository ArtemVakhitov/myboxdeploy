pipeline {
    agent {
        docker {
            image 'docker.io/artemvakhitov/myboxdeploy'
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
            steps {
                sh 'docker build -t $docker_image_tag .'
                sh 'docker push $docker_image_tag'
            }
        }
        stage ('deploy on prod using docker') {
            steps {
                sh '''ssh root@$prod << EOF
	docker pull $docker_image_tag
	docker run -p 80:80 $docker_image_tag
EOF'''
            }
        }
    }
}