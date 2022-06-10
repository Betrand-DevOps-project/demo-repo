pipeline {
      agent any
      environment{
      DOCKERHUB_CREDENTIALS = credentials('bndah-dockerhub')
    }

    stages {

        stage('Clone Repository') {
               steps {
               checkout scm
               }
           }    
          stage('Build Image') {
               steps {
               sh "docker build -t bndah/resumeapp:v1 ."
               }
           }
          stage("Login to DockerHub"){
          /* login in dockerhub  */
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }            
        } 
         stage("Push image DockerHub"){
          /* push docker image to dockerhub */
            steps{
                sh 'docker push bndah/resumeapp:v1'
            }            
        }
         
          
         stage('Create deployment and Service') {
               steps {
               sh 'ansible -m ping all'
               sh 'ansible-playbook deploy.yml'
               }
         }
         stage('expose my app') {
               steps {
               sh 'ssh ec2-user@18.235.34.55 minikube service flask'
               }
         }
         stage('Terraform Init'){
             steps{
                 sh 'terraform init'
             }
         }
         stage ("terraform Action") {
             steps {
                echo "Terraform action is --> ${action}"
                sh ('terraform ${action} --auto-approve') 
             }
         }

         stage('Testing') {
              steps {
                    echo 'Testing...'
                    }
             }     
          
}

}
