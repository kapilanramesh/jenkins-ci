pipeline {
    agent any
    stages {
        stage('plan') {
            steps {
                checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Sedhupathy-devops/jenkins-ci']])
                sh '''terraform init
	terraform plan -state=/var/lib/jenkins/tfstate-manager/proj1.tf'''
            }
        }
        stage('apply') {
            steps {
                sh '''terraform apply -state=/var/lib/jenkins/tfstate-manager/proj1.tf -auto-approve'''
            }
        }
        stage('configure') {
            steps {
               sleep time: 3, unit: 'MINUTES'
        withCredentials([sshUserPrivateKey(credentialsId: 'ansiblekey', keyFileVariable: 'ansiblekey')]) {
    sh '''export PATH=$PATH:/var/lib/jenkins/.local/bin
					 export ANSIBLE_HOST_KEY_CHECKING=False
					 echo "[all]" >inventory
					terraform output -state=/var/lib/jenkins/tfstate-manager/proj1.tf -raw ec2_ip >> inventory
					ansible-playbook -i inventory -u ubuntu --private-key $ansiblekey main.yml'''


}
               
                
            }
        }
    }
}
