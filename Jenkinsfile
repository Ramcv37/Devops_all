pipeline {
    agent { label 'Ram' }
     stages {
      //    stage('Checkout') {
        //    steps {
          //      script {
                  // Get the branch name
            //    def branches = sh(script: 'git branch', returnStdout: true).trim()
                // Get the commit ID
             //   def commitID = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim() 
                
                // Print the information in the desired format
             //   echo "Branch: ${branchName}"
             //   echo "Commit: ${commitID}"
            //    }
          //  }
               
      //  }
        // Add more stages as needed
        stage('Docker stage 2') {
            steps {
               sh ' sudo docker build -t rajismily/project2:latest /var/lib/jenkins/workspace/test'
               sh ' sudo docker tag rajismily/project2:latest rajismily/project2:$BUILD_NUMBER'
               sh ' sudo -S docker images'
            }
        }    
        stage('docker push') {
            steps {
               sh 'sudo docker image push rajismily/project2:latest'
               sh 'sudo docker image push rajismily/project2:$BUILD_NUMBER'
               echo 'till here success looks its working'
            }
        }    
       // stage('Kubernates') {
         //   steps {
           //    sh 'sudo kubectl apply -f /var/lib/jenkins/workspace/Project1/pod.yaml'
            //   sh 'sudo kubectl rollout restart deployment loadbancer-pod'
        //    }
      //  }    
        stage('Success/failure') {
            steps {
               echo 'need to test stages for blue ocean test2'
            }
        }    
    }
}

