pipeline {
    agent any
     stages {
        stage('Git SCM') {
            steps {
               git ' https://github.com/Ramcv37/Devops_all.git'
            }
        }    
        stage('Docker Image') {
            steps {
              
               sh ' sudo docker build -t rajismily/project:latest /var/lib/jenkins/workspace/Kube'
                sh ' sudo -S docker images'
               
            }
        }    
        stage('docker push') {
            steps {
               echo 'need to work on git'
            }
        }    
        stage('Kubernates') {
            steps {
               echo 'need to work on git'
            }
        }    
        stage('Success/failure') {
            steps {
               echo 'need to work on git'
            }
        }    
    }
}

