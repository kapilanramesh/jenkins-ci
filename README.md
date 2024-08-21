# jenkins-ci

# Jenkins CI/CD pipeline

checklist:
  - [ ] create a t2-medium instance
  - [ ] install java
  - [ ] install jenkins
  - [ ] install terraform
  - [ ] install ansible
  - [ ] awscli
  - [ ] aws configure
  - [ ] terraform plan
  - [ ] terraform apply
  - [ ] ansible run
  - [ ] terraform destroy



## why t2-medium:

  need 4gb of ram minimum to run multiple process

## use ubuntu-22.04:
  this documentation is based on ubuntu-22.04. If you are a beginner and going follow this doc then recommended to use same image

## basic setup (optional)

```
sudo timedatectl set-timezone Asia/Kolkata
sudo hostnamectl hostname ci-server
```
## install java

we need to install java first because jenkins runs on java so its a pre-requisite

```
sudo apt update
sudo apt install fontconfig openjdk-17-jre
java -version
```

## install jenkins

```
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl status jenkins
sudo systemctl start jenkins
```


## update security-group

- open port **8080** in which jenkins runs as default

## Install Terraform 

```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```


## create tf-state manager directory

```
 sudo su jenkins
 cd
 pwd #(/var/lib/jenkins)
 mkdir /var/lib/jenkins/tfstate-manager
```
remember the owner of the directory should be user jenkins 

create an ssh-key
```
 sudo su jenkins
 cd
 pwd #(/var/lib/jenkins)
 ssh-keygen
```

## awscli

Install awscli

```
sudo apt install awscli #RUN AS UBUNTU USER
```

run aws configure and add iam user key and region

```
aws configure #jenkins user
```

remember the region in the awscli and provider.tf should be same

## Install Ansible 
```
sudo apt install pipx
sudo su jenkins
pipx install --include-deps ansible
export PATH=$PATH:/var/lib/jenkins/.local/bin
ansible --version
```
## jenkins setup

now copy the public of ip of the vm and search with :8080 in the end

```
<public_ip>:8080
```

you should be prompted to the login page

### initial admin password
It is stored in a file. Enter the following command in shell then copy and paste it in the page
![Pasted image 20240821174345](https://github.com/user-attachments/assets/48fe258b-d63c-45bd-96d4-d40bd46dcaec)


```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```


### select install custom plugins
choose the following plugins shown

![Pasted image 20240821174559](https://github.com/user-attachments/assets/5240e8aa-81b3-45a8-ae5d-0b7f346212a8)



### create jenkins admin user

![Pasted image 20240821174921](https://github.com/user-attachments/assets/a7ae3ad0-2752-42b2-b717-67a3395176cc)


### fork/clone this to your github account

```
https://github.com/Sedhupathy-devops/jenkins-ci
```


### copy the ssh public key

```
cat /var/lib/jenkins/.ssh/id_rsa.pub
```

### add it to main.tf file in repo 

replace this with your copied public_key
![Pasted image 20240821222133](https://github.com/user-attachments/assets/9ad79d37-6885-4a95-87e3-8d381e37e37f)

## create a jenkins job1
#### click on the +New Item

![Pasted image 20240821174951](https://github.com/user-attachments/assets/f5a4e03d-1f40-40fe-82d7-4610e2791731)


#### select free-style project
- Enter the name as **terraform_plan**
![Pasted image 20240821181219](https://github.com/user-attachments/assets/8eaffb6d-e821-4735-a929-d741d518e20b)



### Add description and github project url


```
 use your github account url 
```
![Pasted image 20240821175240](https://github.com/user-attachments/assets/77206b8f-f662-4c46-8c1e-79fb87a404c8)


![Pasted image 20240821175259](https://github.com/user-attachments/assets/fc709867-111c-4778-be6a-1a95c67ac18b)


![Pasted image 20240821183227](https://github.com/user-attachments/assets/c0446974-5771-4a53-8639-84a52df15f00)


```
terraform init
terraform plan -state=/var/lib/jenkins/tfstate-manager/proj1.tf
```
 to understand what is tf-state file refer: https://developer.hashicorp.com/terraform/language/state



**<------------ the terraform plan job ends here run and test the job ------------->**

## create a jenkins job2
The purpose of this job is to run terraform apply and create resources 

create a new job **terraform-apply** and repeat the same steps as terraform-plan job till execute shell 

Add this in the execute shell instead of terraform plan
```
terraform init
terraform apply -state=/var/lib/jenkins/tfstate-manager/proj1.tf -auto-approve
```


**<------------ the terraform-apply job ends here run and test the job ------------->**

## create a jenkins job3

The purpose this job is to install nginx on the newly created server

### copy the ssh private key

```
cat /var/lib/jenkins/.ssh/id_rsa
```


### Add privatekey as a secret in jenkins

![Pasted image 20240821213429](https://github.com/user-attachments/assets/b6851414-dcea-4c19-a58b-b2536880f837)




### create a new job named ansible run
![Pasted image 20240821222504](https://github.com/user-attachments/assets/147b70ff-e57b-4f1b-a7f6-db3130a69a59)


give a variable name as jenkinskey to the added secret
![Pasted image 20240821222547](https://github.com/user-attachments/assets/7e2c4d36-b929-46f7-af86-89e77687bd1c)



Update the execute shell path with following commands
```
export PATH=$PATH:/var/lib/jenkins/.local/bin
export ANSIBLE_HOST_KEY_CHECKING=False
echo "[all]" >inventory
terraform output -state=/var/lib/jenkins/tfstate-manager/proj1.tf -raw ec2_ip >> inventory
ansible-playbook -i inventory -u ubuntu --private-key $jenkinskey main.yml
```

![Pasted image 20240821222723](https://github.com/user-attachments/assets/2c4a47a1-1024-4c80-b0e9-890197855f87)




**<------------ the ansible-run job ends here run. and test the job ------------->**


## terraform destroy (optional) Job 4 

if you want another workflow to destroy the resources created using terraform follow these steps

create a job named **terraform-destroy**

follow the same steps you did for **terraform-apply** job

except update this in the execute shell

```
terraform init
terraform destroy -state=/var/lib/jenkins/tfstate-manager/proj1.tf -auto-approve
```


**<------------ the terraform-destroy job ends here. run and test the job ------------->**




So as a final outcome of this project you should have 4 jenkins jobs created

- terraform plan
- terraform apply
- terraform destroy
- ansible run

These industry-standard workflows are integral to this project. A solid understanding of these concepts will enable you to confidently identify yourself as a junior DevOps engineer(Linux, aws, terraform, ansible,  webserver and network configuration )


