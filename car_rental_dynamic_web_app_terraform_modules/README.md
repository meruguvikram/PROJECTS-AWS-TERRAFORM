# Dynamic Web App on AWS with Terraform Modules, Docker, Amazon ECR, and ECS

![Screenshot (547)](https://github.com/user-attachments/assets/259413e6-a161-44c5-9df4-c1feacdc66bb)

Thrilled to announce the completion of my latest project: a fully operational dynamic web application deployed and hosted on AWS using Terraform Modules, Docker, Amazon ECR, and Amazon ECS!

This project is distinguished by the extensive use of AWS services, guaranteeing high availability, scalability, and robust security. It showcases the capability to design and implement intricate infrastructure solutions following modern DevOps methodologies.

rentzone-infrastructure-ecs repository: https://github.com/Silas-cloudspace/rentzone-infrastructure-ecs

terraform-modules repository: https://github.com/Silas-cloudspace/terraform-modules

## PROJECT

## Create and Clone a Repository for storing Terraform Modules

Create a new repository in GitHub and call it “terraform-modules”

Make it private

Clone it to your desired location.

## Create Terraform Module for VPC

Open VS Code and navigate to the “terraform-modules” directory

Create a new folder: mkdir vpc

Create 3 new files in the “vpc” folder: touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created vpc module”
  
  •	git push

## Create and clone a Terraform Infrastructure Code Repository

Create and clone to your computer a new repository for the project that we will use to deploy our application.

I’ve named mine “rentzone-infrastructure-ecs”

## Create a S3 bucket and a Dynamodb table

For storing the Terraform state in the S3 and for locking Terraform state in the Dynamodb

Go to VS Code and create a new folder and name it “remote_backend” in the “rentzone-infrastructure-ecs” directory

  •	mkdir remote_backend

Navigate to this new folder and create a new file: “backend”

  •	touch backend

Copy the terraform file from the shared repository into it.

Run: terraform init and terraform apply

## Create Terraform Provider

Navigate to the “rentzone-infrastructure-ecs” directory

touch providers.tf variables.tf

Copy the terraform files from the shared repository into them.

## Create Terraform backend

touch backend.tf

Copy the terraform file from the shared repository into it.

Run: terraform init

## Create a 3 tier VPC

touch main.tf

Copy the terraform file from the shared repository into it.

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

We add //vpc to the end of the SSH URL because the module is located in the vpc folder

You need to do the same for the following modules that we create

![image](https://github.com/user-attachments/assets/8a67b165-5eaa-49aa-9d0b-40b84d46ed1c)

touch terraform.tfvars

Copy the terraform file from the shared repository into it.

create a .gitignore.tf file and add the”terraform.tfvars” into it

### Important: Your code will be bigger but run it only until the “module ‘vpc’”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init 
  
  •	terraform apply

## Create Terraform Module for Nat Gateway

Navigate to the “terraform-modules” directory

mkdir nat_gateway

cd nat_gateway

touch main.tf variables.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created nat gateway module”
  
  •	git push

## Create NAT Gateways for the VPC

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //nat_gateway to the end of the SSH URL because the module is located in the GitHub “nat_gateway” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘nat_gateway’”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for the security groups

Navigate to the “terraform-modules” directory

mkdir security_groups

cd security_groups

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created security groups module”
  
  •	git push

## Create Security Groups for the VPC

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //security_groups to the end of the SSH URL because the module is located in the GitHub “security_groups” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘security_group”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for the Database

Navigate to the “terraform-modules” directory

mkdir rds

cd rds

touch main.tf variables.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created rds module”
  
  •	git push

## Create Database for the VPC

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //rds to the end of the SSH URL because the module is located in the GitHub “rds” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘rds”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for the ACM

Navigate to the “terraform-modules” directory

mkdir acm

cd acm

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created acm module”
  
  •	git push

## Request SSL certificate for your AWS Resources

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //acm to the end of the SSH URL because the module is located in the GitHub “acm” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘ssl_certificate”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for the Application Load Balancer

Navigate to the “terraform-modules” directory

mkdir alb

cd alb

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created alb module”
  
  •	git push

## Create the Load Balancer

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //alb to the end of the SSH URL because the module is located in the GitHub “alb” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘application_load_balancer”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create a private repository to store the application codes 

Go to GitHub and create a new repository.

I’ve named mine “application-codes-autorentify-project”

Download the required file from this link: https://github.com/Silas-cloudspace/application-codes-autorentify-project

Add it to the repository folder in your local machine

Open the repository “application-codes-autorentify-project” on VS code

Push it to GitHub “application-codes-autorentify-project”

## Create a personal access token on github

This token will be used by docker to clone the application codes repository when we build our docker image

Github -> select your profile -> settings -> Developer settings -> Personal access tokens -> Tokens (classic) - > Generate new token -> Generate new token classic

Edit it as you see in the following example: 

![image](https://github.com/user-attachments/assets/897e71d8-bb49-448d-a2ca-37a2dc91e60b)

Remember to copy your personal access token and save it anywhere

## Create a Dockerfile

Create a new repository on GitHub and call it “docker-projects”

Open the repository docker-projects in VS Code

Create a new folder for the application. 

  •	Run: mkdir rentzone

  •	cd rentzone

  •	touch Dockerfile

copy and paste into it the following: https://github.com/Silas-cloudspace/docker-projects/blob/main/rentzone/Dockerfile

We will use a LAMP stack to build this application. A lamp stack is a group of open-source software that we can use to build a dynamic web application:

![image](https://github.com/user-attachments/assets/3d5e8365-7b72-45c2-9487-22f073275cd4)
 
  •	Linux is the operating system we will use to run the stack.

  •	Apache is the software we will use to serve the website.

  •	MySQL is the engine we will use to run our database.

  •	php is the programming language used to build web applications.

On line 93 we will replace the file named “AppServiceProvider.php” on our server.

We do this because we want to upload a value in it, so when we redirect our traffic from http to https our website function properly.

•	Create the replacement file in our project folder

  o	Copy “AppServiceProvider.php”

  o	In VS code navigate to rentzone folder

  o	Create a new file and name it “AppServiceProvider.php”

  o	Paste into it the following: https://github.com/Silas-cloudspace/docker-projects/blob/main/rentzone/AppServiceProvider.php

   o	This file is to redirect http traffic to https

## Create a script to build the Docker image

Navigate to the “rentzone” directory in VS Code 

Create a new file

  o	Run: touch build_image.ps1  (build_image.sh for mac)

Copy and paste into it the following: https://github.com/Silas-cloudspace/docker-projects/blob/main/rentzone/build_image.ps1

Create a “.gitignore” file and add into it the “build_images.ps1”

## Make the script executable

Windows: 

  •	Open powershell by running it as administrator in your computer

  •	Run the following command: Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process

Mac:

  •	Run: chmod +x build_image.sh

## Build the Docker Image

Make sure you have Docker running on your machine

Navigate to rentzone directory on VS Code

Use powershell terminal and run:
.\build.image.ps1 (build_image.sh for mac)

Run: docker image ls

Now we can see the image we just built

## Create a repository in Amazon ECR

aws cli command to create an amazon ecr repository:

  o	aws ecr create-repository --repository-name <repository-name> --region <region>

Navigate to rentzone directory on VS Code and run:

  o	aws ecr create-repository --repository-name rentzone --region eu-west-2

## Push the Docker image to the Amazon ECR repository

### Retag docker image

o	Run: docker tag <image-tag> <repository-uri>

  •	You can check the tag name you gave to your image by running “docker image ls”. In this case you will see the name “rentzone”

  •	In order to get the repository uri, go to ECR in the AWS console

### login to ecr

Run: aws ecr get-login-password | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<region>.amazonaws.com

### push docker image to ecr repository 

Run: docker push <repository-uri>

### Run: docker tag rentzone 381491868231.dkr.ecr.eu-west-2.amazonaws.com/rentzone

If you run “docker image ls” you can check that the image was retagged succefully

### Push the image into Amazon ECR

For this, first we need to login into ECR.

Run: aws ecr get-login-password | docker login --username AWS --password-stdin 381491868231.dkr.ecr.eu-west-2.amazonaws.com

### Push the docker image into the ECR repository

Run: docker push 381491868231.dkr.ecr.eu-west-2.amazonaws.com/rentzone

## Create an environment file 

We will now create an environment file to store the environment variables we defined in our Dockerfile.

Open “docker-projects” directory in VS Code

cd rentzone

touch rentzone.env

Paste into it the following: https://github.com/Silas-cloudspace/docker-projects/blob/main/rentzone/rentzone.env

Replace it with your own information

Add “rentzone.env” to the .gitignore 

git add .

git commit -m “created environment files”

git push

## Create Terraform Module for S3 bucket

Navigate to the “terraform-modules” directory

mkdir s3

cd s3

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created s3 module”
  
  •	git push

## Create the S3 bucket

This bucket will be used to upload the environment file we created.

When we create the ECS tags, the ECS tag will retrieve the environment variables from the file in the S3 bucket.

Copy the “rentzone.env” file stored in your computer on docker-projects > rentzone to “rentzone-infrastructure-ecs” directory in VS Code

 ![image](https://github.com/user-attachments/assets/26308926-98dc-46cc-9ba8-b2fb449c7d68)

Add “rentzone.env” to .gitignore

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //s3 to the end of the SSH URL because the module is located in the GitHub “s3” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘s3_bucket”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for the Task Execution Role

Navigate to the “terraform-modules” directory

mkdir iam_role

cd iam_role

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created iam_role module”
  
  •	git push

## Create a Task Execution Role for your ECS Tasks

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //iam_role to the end of the SSH URL because the module is located in the GitHub “iam_role” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘ecs_task_execution_role’”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for ECS clusters, Task Definition and Service

Navigate to the “terraform-modules” directory

mkdir ecs

cd ecs

touch main.tf variables.tf outputs.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created ecs module”
  
  •	git push

## Create an ECS Cluster Task Definition and Service

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //ecs to the end of the SSH URL because the module is located in the GitHub “ecs” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘ecs”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for ECS Auto Scaling Group

Navigate to the “terraform-modules” directory

mkdir asg_ecs

cd asg_ecs

touch main.tf variables.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created asg_ecs module”
  
  •	git push

## Create an ECS Auto Scaling Group

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //asg_ecs to the end of the SSH URL because the module is located in the GitHub “asg_ecs” folder we recently created

### Important: Your code will be bigger but run it only until the “module ‘asg_ecs”. Comment the rest of it by:

  •	For Windows/Linux: Press Shift + Alt + A
  
  •	For macOS: Press Shift + Option + A

Run:

  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

## Create Terraform Module for Route53

Navigate to the “terraform-modules” directory

mkdir route53

cd route53

touch main.tf variables.tf

Copy the terraform files from the shared repository into them.

Run:

  •	git add .
  
  •	git commit -m “created route53 module”
  
  •	git push

## Create Route53 DNS Records

Navigate to the “rentzone-infrastructure-ecs” directory

Go to the main.tf file

Replace the source with the SSH URL of your terraform-modules repository in your GitHub account

Add //route53 to the end of the SSH URL because the module is located in the GitHub “route53” folder we recently created

Run:

  •	git add .
  
  •	git commit -m “updated files”
  
  •	git push
  
  •	terraform fmt
  
  •	terraform init
  
  •	terraform apply

### ctrl+click on the url and you will see the deployed application on AWS using Terraform Modules and ECS Fargate.
