
# PROJECT – 2   Trend Store

![image](https://github.com/anitodevops/Project-2/blob/main/Images/Frontimage.png)

### Table Of Contents 

-	[Goal](https://github.com/anitodevops/Project-2#goal)
-	[Pre-Requisites](https://github.com/anitodevops/Project-2#pre-requisites)
-	[Application Deployment Architecture](https://github.com/anitodevops/Project-2#application-deployment-architecture)
-	[Architecture Overview](https://github.com/anitodevops/Project-2#architecture-overview)
-	[Steps to Build, Deploy & Monitor](https://github.com/anitodevops/Project-2#steps-to-build-deploy-monitor)
-	[Links](https://github.com/anitodevops/Project-2#links)
-	[Outcome](https://github.com/anitodevops/Project-2#outcome)

## Goal

Deploy the React Application to a Production Ready State & to ensure that it runs on Port 3000.

## Pre-Requisites
-	[AWS Account](https://signin.aws.amazon.com/signup?request_type=register)
-	[GitHub Account](https://github.com/)
-	[DockerHub Account](https://hub.docker.com/)
-	[Source Code](https://github.com/Vennilavan12/Trend.git)
  
## Application Deployment Architecture 

![Architecture](https://github.com/anitodevops/Project-2/blob/main/Images/Architecture.png)

## Architecture Overview

- Developer provisions AWS infrastructure Via Terraform.
- Code Push is made into GitHub repository invokes gitHub webhook triggering Jenkins pipeline.
- ﻿﻿﻿Jenkins fetches code from Github.
- Jenkins builds Docker image to pushes to DockerHub.
- ﻿﻿﻿Jenkins deploys the image to EKS via kubectl.
- ﻿﻿﻿Monitoring ensures application and cluster health.

## Steps To Build, Deploy, Monitor 

> Below is the step-by-step implementation breakdown of the complete DevOps CD process.

[Step 1: Infrastructure Provisioning (Terraform)](https://github.com/anitodevops/Project-2/blob/main/Steps/Step1.md)

[Step 2: Setup Git Repository](https://github.com/anitodevops/Project-2/blob/main/Steps/Step2.md)

[Step 3: Dockerize the Application](https://github.com/anitodevops/Project-2/blob/main/Steps/Step3.md)

[Step 4: Setup DockerHub Repository](https://github.com/anitodevops/Project-2/blob/main/Steps/Step4.md)

[Step 5: EKS Cluster Creation](https://github.com/anitodevops/Project-2/blob/main/Steps/Step5.md)

[Step 6: K8's Object Creation](https://github.com/anitodevops/Project-2/blob/main/Steps/Step6.md)

[Step 7: Jenkins Pipeline Setup](https://github.com/anitodevops/Project-2/blob/main/Steps/Step7.md)

[Step 8: GitHub Webhook Setup](https://github.com/anitodevops/Project-2/blob/main/Steps/Step8.md)

[Step 9: Validate Jenkins Pipeline](https://github.com/anitodevops/Project-2/blob/main/Steps/Step9.md)

[Step 10: Setup Monitoring](https://github.com/anitodevops/Project-2/blob/main/Steps/Step10.md)

[Step 11: Dashboard Creation](https://github.com/anitodevops/Project-2/blob/main/Steps/Step11.md)

## Links

-	Application LoadBalancer URL: http://ac04a9310846543e5a0c2f0b39daa023-1003803771.ap-south-1.elb.amazonaws.com

-	Jenkins: http://3.109.186.176:8080/
  
-	Dockerhub: https://hub.docker.com/repository/docker/anitodevops/trendstore/general


## Outcome

- Fully automated CI/CD pipeline with Infrastructure as Code (IaC).
- Seamless deployment of a Dockerized React app to AWS EKS.
- Continuous integration on Git push and continuous deployment via Jenkins.
- Real-time monitoring for cluster and app stability.



