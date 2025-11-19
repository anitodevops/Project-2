# Step 10: Setup Monitoring

### Install Prometheus Grafana Blackbox NodeExporter :
Install prometheus, Grafana, alert manager & Kube-state-metrics using helm charts to track :
- Pod health
- Node Metrics
- Application Logs
---
1. Create namespace - monitoring 

`kubectl create namespace monitoring`

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring

Output:
NAME: kube-prometheus
LAST DEPLOYED: Wed Nov  5 14:24:46 2025
NAMESPACE: monitoring
STATUS: deployed
REVISION: 1
```
	Note:
	Get your grafana admin user password by running:
	  kubectl get secret --namespace monitoring -l app.kubernetes.io/component=admin-secret -o jsonpath="{.items[0].data.admin-password}" | base64 --decode ; echo

	Check aws console - eks cluster info on workloads, whether namespace is created or not ; also save the output of prometheus installation in a notepad for future reference.

- Check if pods are running : 
```
kubectl get pods -n monitoring
kubectl get svc -n monitoring 
```
### Scrape Application Metrics.
```
cat scrape.yaml 
prometheus:
  prometheusSpec:
    additionalScrapeConfigs:
      - job_name: 'application-health'
        metrics_path: /probe
        params:
          module: [http_2xx]
        static_configs:
          - targets:
            - http://ac957fecbfd2a47169c85cada240a267-1342207695.ap-south-1.elb.amazonaws.com:80
        relabel_configs:
          - source_labels: [__address__]
            target_label: __param_target
          - target_label: __address__
            replacement: blackbox-exporter-prometheus-blackbox-exporter.default.svc.cluster.local:9115
          - source_labels: [__param_target]
            target_label: instance
```
```
helm upgrade kube-prometheus prometheus-community/kube-prometheus-stack   -n monitoring -f scrape.yaml
```
![prometheus](https://github.com/anitodevops/Project-2/blob/main/Images/Prometheus.png)

### Update Config - Spec - LoadBalancer

#### Edit config update spec: type: clusterIP to LoadBalancer

`kubectl edit svc kube-prometheus-kube-prome-prometheus -n monitoring `

service/kube-prometheus-kube-prome-prometheus edited

#### Edit config update spec: type: clusterIP to LoadBalancer

`kubectl edit svc kube-prometheus-grafana -n monitoring`

service/ kube-prometheus-grafana edited

Monitoring Tool URL's :

Grafana : http://a2a36a787160d44e29d0de2b3c3778bb-1965368686.ap-south-1.elb.amazonaws.com:80

Prometheus: http://a0ef367f82639409a9b085d53c69f022-2074004483.ap-south-1.elb.amazonaws.com:9090/targets

![monitor](https://github.com/anitodevops/Project-2/blob/main/Images/Monitoring%20using%20Helm%20charts.png)
