
# Step 6: K8's Object Creation

### Create Deployment manifest file with below specification.

[deployment.yaml](https://github.com/anitodevops/Project-2/blob/main/deployment.yaml) 

    spec:
      containers:
        - name: trendstore-cont
          image: anitodevops/trendstore:latest
          ports:
            - containerPort: 3000 

#### Command to create deployment:

	`kubectl apply -f deployment.yml`

- checks deployments

	`kubectl get deploy	`

- checks Pod status 

	`kubectl get pods  `

- checks node availability

	`kubectl get nodes    `

- checks replicas sets status

	`kubectl get rs	`

### Commands to delete deployment 
```
kubectl delete deploy trendstore-deploy 
			(or)
kubectl delete -f deployment.yml
```

### Create Service manifest file with below specification.
 
[service .yaml](https://github.com/anitodevops/Project-2/blob/main/service.yaml)

spec:
  type: LoadBalancer
  selector:
    app: trendify
  ports:
    - name: http
      port: 80
      targetPort: 3000


#### Command to Create Service:
`kubectl apply -f service.yml `

 - checks services created.
	`kubectl get svc`

**NOTE
update the SG of the nodegroup -> port 3000 , source to ALB SG**
 

### Steps for Troubleshooting:
```
kubectl describe pod <podname>
kubectl get pods -o wide
kubectl logs <pod-name>
kubectl logs -l app=trendify
kubectl run testpod --rm -it --image=busybox – sh
```
### Common Errors:
1.	Warning  FailedScheduling  5m6s  default-scheduler  0/2 nodes are available - change nodetype to t3.medium.
2.	Too many pods. preemption: 0/2 nodes are available:  - choose/Increase 2 and nodetype from t2.micro to t3.medium 
3.	ErrImagePull - image is missing in dockerhub registry
4.	ImagePullBackOff -image name is incorrect in deploy.yaml  
