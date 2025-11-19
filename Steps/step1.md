
# Step: 1 Infrastructure Provisioning (Terraform)


Terraform harshicorp plugins installation in visual studio code
Write Main.tf – VPC, SG, IAM, EC2 with Jenkins.
Use terraform plan , apply and destroy command to create , delete infrastructures.

1. Download visual studio code
2. Install awscli in local  workspace
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt install zip -y
unzip awscliv2.zip
./aws/install
```
	`aws --version`
	
3.	Install on below extension 
	- harshicorp HCL
	- HarshiCorp Terraform
	- Terraform Plus

	validate using command 
	
		`terraform -v`

4.	Connect to AWS via   `aws configure`

-	Access key :    AK*************O52
- Secret Key : abdksj********************fhy
- Choose region – ap-south-1
- Format – json

5.	Create terraform file with provider & resource block. 
[main.tf](https://github.com/anitodevops/Project-2/blob/main/main.tf)
- Provider: AWS
- Resources: VPC, Subnets, Route Table Associations, IGW, SG, EC2, IAM Role - EC2, Cluster, NodeGroup & their IAM Policies.
- [User data](https://github.com/anitodevops/Project-2/blob/main/user_data.sh) - Installs docker, Jenkins, awscli, eksctl, kubectl packages into EC2.

6. Initialize terraform

	`terraform init`

7. Preview infrastructure creation before applying.

	`terraform plan`

8. To Provision infrastructure.
	```
	terraform apply       						-> choose yes or no 
		(or)
	terraform apply --auto-approve   ->provision without approval  
	```
	![applyoutput](https://github.com/anitodevops/Project-2/blob/main/Images/Terraform%20Output.png)

9. Verify in aws console or check for terraform statefile & statebackup file creation 

	![awsoutput](https://github.com/anitodevops/Project-2/blob/main/Images/infrastructure%20creation.png)
 
11. To displays contents of statefile
		`terraform show`

Note: 
Use `terraform destroy ` to terminates all resources in ec2 &  deletes contents of statefile.

12.**Validate packages & services in Jenkins Server**
```
docker -v

jenkins --version

systemctl status jenkins 

systemctl status docker

aws --version

eksctl version

kubectl version –client
```

