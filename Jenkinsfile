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
              
               sh ' sudo docker build -t rajismily/project1:latest /var/lib/jenkins/workspace/Project1'
               sh ' sudo docker tag rajismily/project1:latest  rajismily/project1:${Build_number}'  
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

