pipeline {
   agent any
  
   environment {
       DOCKER_HUB_REPO = "arunbhosale/flask-hello-world"
       CONTAINER_NAME = "flask-hello-world"
       registry = "arunbhosale/flask-hello-world"
       registryCredential = 'dockerhub'
       dockerImage = ''
   }
  
   stages {
       /* We do not need a stage for checkout here since it is done by default when using "Pipeline script from SCM" option. */
      
       stage('Build') {
           steps {
               script {
                   dockerImage = docker.build registry + ":latest"
               }
           }
       }
       stage('Test') {
           steps {
               echo 'Testing..'
               sh 'docker stop $CONTAINER_NAME || true'
               sh 'docker rm $CONTAINER_NAME || true'
               sh 'docker run --name $CONTAINER_NAME $DOCKER_HUB_REPO /bin/bash -c "pytest test.py && flake8"'
           }
       }
       stage('Push') {
           steps {
               script {
                   docker.withRegistry( '', registryCredential ) {
                       dockerImage.push()
                   }
               }
           }
       }
       stage('Deploy') {
           steps {
               echo 'Deploying....'
               sh 'minikube kubectl -- apply -f deployment.yaml'
               sh 'minikube kubectl -- apply -f service.yaml'
           }
       }
   }
}
