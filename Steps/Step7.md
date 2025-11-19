
# Step 7: Jenkins Pipeline Setup

### Access jenkins 

Jenkins URL - **http://3.109.186.176:8080/**

![login](https://github.com/anitodevops/Project-2/blob/main/Images/Jenkins%20setupLogin.png)

### Get the password to login to jenkins.

```sudo cat <path-/var/.../>```

### Choose Install default plugins

Jenkins by default installs few packages to perform basic tasks.

### Update Username & Credentials 

![orgLogin](https://github.com/anitodevops/Project-2/blob/main/Images/Jenkins%20Login.png)

### Install Additional Plugins

- Go to Jenkins->Manage jenkins -> Plugins ->Available Plugins -> Search Plugins & Click Install.
			- Docker, Docker commons, Docker pipeline
			-  Kubernetes, Kubernetes CLI
			-  Pipeline stage view,
			-  aws credentials, pipeline aws steps
			
- Enable restart after installing plugins as a best practice.

### Configure Jenkins Global credentials.

- Go to Jenkins -> Manage jenkins ->Credentials -> System -> Global credentials -> add credentials 
- For : github, dockerhub, awscli
- Add Choose Username with password, Enter 
	- Name
	- ID
	- Username
	- Password
	- Description

![credentials](https://github.com/anitodevops/Project-2/blob/main/Images/Jenkins%20Credentials%20.png)

Note: ID will later be used in the Jenkinsfile to invoke the credentials inside the pipeline.

### Setup Pipeline

- Go to Jenkins -> Create new item -> choose -> Enter Pipeline name -> choose Single Pipeline -> OK

- In General : Enter Display Name , Description , Enable webhook trigger

- In Branch Source : choose GitHub -> choose github Credentials -> enter github Repo HTTPS URL , click validate,   choose branch -> main 

-  In Build Configuration :  choose PipelineScriptfromSCM -> mode: by Jenkinsfile , script path: Jenkinsfile (filename as in github)

#### *Three Stages of Jenkinsfile *

1. Builds image from dockerfile 
2. Pushes to registry – anitodevops/trendify-app:build_no & anitodevops/trendify-app:latest
3. Deploy – pull anitodevops/trendify-app:latest & deploys to EKS via Kubectl 

[Jenkinsfile](https://github.com/anitodevops/Project-2/blob/main/Jenkinsfile)
