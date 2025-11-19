
# Step 11: Dashboard Creation

### Configure Data Source
• Go to → Connections → Data Sources
•	Click “Add new connection”
•	Search for Prometheus
•	Click “Prometheus” → “Add new data source”
• Configure Prometheus Connection
•	Name: my-cluster-prometheus
•	URL - (http://kube-prometheus-kube-prome-prometheus.monitoring.svc.cluster.local:9090)
•	Access: Server (default)
•	Click “Save & Test”

### Create Dashboard
•  Provide the Dashboard ID and Click “Load”
•  Select Data Source ->Choose your Prometheus data source ( my-cluster-prometheus).
•  Click “Import”
Displays - *Prometheus is now successfully connected to Grafana.*

![dashbaords](https://github.com/anitodevops/Project-2/blob/main/Images/Trendstore%20Dashboards.png)

>Create dashboards or use pre-built ones to visualize:

>Metrics -> (sources)
>1. Node metrics ( Node Exporter)
>2. Pod/Deployment metrics ( Kube-State-Metrics)
>3. Cluster health and resource utilization  (CloudWatch)
>4. Application health ( Blackbox)	

#### Dashboard IDS: 
- 15661 k8s dashboard – cluster , nodes , pods
![clustermetrics](https://github.com/anitodevops/Project-2/blob/main/Images/Cluster%20Metrics%20Dashboard.png)

- 13332 – Tracks deployment, pods, containers

![Kubestate](https://github.com/anitodevops/Project-2/blob/main/Images/Kube-state-Metrics.png)

- 1860 – node metrics

![clusterExport](https://github.com/anitodevops/Project-2/blob/main/Images/Cluster%20Metrics%20Dashboard.png)

-7586 - Application health

![health](https://github.com/anitodevops/Project-2/blob/main/Images/Application%20Health.png)

- Application Logs via AWS CloudWatch 

![cloudwatch](https://github.com/anitodevops/Project-2/blob/main/Images/Cloudwatch%20Dashbaord.png)





