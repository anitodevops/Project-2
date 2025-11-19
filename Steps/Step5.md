
# Step 5: EKS Cluster Creation

### AWS configuration in Jenkins Server:

```
aws configure

Access key :    AKI******************KO52
Secret Key : j5H***********************6k2Lpq
choose region – ap-south-1 & format – json
```

### Creating cluster using clusterConfig manifest file

Creating cluster for app deployment – container will run on these nodes. 

[eks_cluster.yaml](https://github.com/anitodevops/Project-2/blob/main/eks_cluster.yaml)

Run below command to create cluster

`eksctl create cluster -f eks_cluster.yaml`

Alternative method to create Cluster in command line :
```
eksctl create cluster \
--name trendstore-cluster \
--region ap-south-1 \
--nodegroup-name linux-ubuntu \
--node-type  t3.medium \
--nodes 2 \
--managed \
```

Cluster creation verification :

In terminal:

`kubectl cluster-info`

![ekscluster](https://github.com/anitodevops/Project-2/blob/main/Images/EKS%20cluster%20creation.png)

In AWS console:
- Go to AWS Elastic Kubernetes Service dashboard 

![awsconsole](https://github.com/anitodevops/Project-2/blob/main/Images/cluster_aws.png)

To check if nodes are created use:

`kubectl get nodes`
