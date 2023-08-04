apt-get update
   sudo apt install openjdk-11-jdk -y
 java --version 

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
# Add the Jenkins software repository to the source list and provide the authentication key:
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

#    Step 2.3 : Install Jenkins

sudo apt update
sudo apt install jenkins -y
 sudo systemctl status jenkins 
# (Exit the status screen by pressing Ctrl+Z.)
 sudo systemctl enable --now jenkins
 sudo ufw allow 8080
sudo ufw status
 sudo ufw enable   
