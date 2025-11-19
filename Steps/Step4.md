
# Step 4: Setup DockerHub Repository

### Login to DockerHub

[DockerHub SignIn](https://hub.docker.com) 

### Generate DockerHub Access Token

##### Go to DockerHub -> Account settings -> Personal Access Token -> click Generate New Token 
  
    - Enter Token description

    - Choose Expiration Date – 30/60/90 Days
    
    - Choose Access Permissions (Read, Write) 
    
    - Click Generate

### Create a DockerHub repository

- Click create new repository
	-  name – anitodevops/trendstore
	- visibility - Public
	- save
	
- In Terminal - connect to dockerhub to  push docker images to the 

	`docker login`

click on dockerhub login active link & paste the one-time password generated & confirm. 

`docker push anitodevops/trendstore:latest`

