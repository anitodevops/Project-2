
# Step 3: Dockerize the Application

### [Dockerfile](https://github.com/anitodevops/Project-2/blob/main/Dockerfile)
	
Using base image - node:apline	& exposing to port 3000
By default nginx listens to  port 80.

### Create deafult.conf file 

Creating default.conf for nginx to listen to port 3000  app runs on port 3000.
```
cat default.conf
server {
    listen 3000;
    server_name localhost;
    root /usr/share/nginx/html;
    index index.html;
    location / {
        try_files $uri $uri/ /index.html;
    }
    error_page 404 /index.html;
}
```
### Build docker image

`docker build -t anitodevops/trendstore:latest . `

### View docker images

`docker images`

### Run docker container using docker image.

`docker run -d --name trendstore-cont -p 3000:3000 anitodevops/trendstore:latest`

### View running docker containers 

` docker ps `

![dockerimg](https://github.com/anitodevops/Project-2/blob/main/Images/Docker%20Build%20%26%20Run.png)
Note:
•	Updated SG of Jenkins-server to custom TCP , port - 3000, Source anywhere ipv4.

•	Browser verification :     http://3.110.209.81:3000/

![dockeroutput](https://github.com/anitodevops/Project-2/blob/main/Images/docker_run_output.png)
