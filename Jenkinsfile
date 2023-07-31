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
<<<<<<< HEAD
               sh ' sudo docker tag  rajismily/project1:latest rajismily/project1:${BUILD_NUMBER}'  
              sh ' sudo -S docker images'
=======
               sh ' sudo docker tag rajismily/project1:latest rajismily/project1:$BUILD_NUMBER'
               sh ' sudo -S docker images'
>>>>>>> 4b399bf3504a58d36d816aacf93ca205fd8481f7
               
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

