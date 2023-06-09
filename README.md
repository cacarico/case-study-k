## Case Study K

This repository contains files to deploy, maintain and configure Case Study K. 
The project's objective is to create a virtual machine, install Apache, and create a reverse proxy to the Kubernetes cluster.
Here you will also find the Helm Charts used to deploy the web-server and also the Istio Installation files.

```
.
├── ansible/roles
│       └── apache
│           ├── handlers
│           ├── hosts
│           ├── playbook.yml
│           ├── tasks
│           ├── templates
│           └── vars
├── chart
│   ├── Chart.yaml
│   ├── templates
│   │   ├── deployment.yaml
│   │   ├── destination-rule.yaml
│   │   ├── gateway.yaml
│   │   ├── _helpers.tpl
│   │   ├── horizontalpodautoscaler.yaml
│   │   ├── service-account.yaml
│   │   ├── service.yaml
│   │   └── virtual-service.yaml
│   └── values.yaml
├── istio
│   ├── istio-operator.yaml
│   └── peerauthentication.yaml
├── Makefile
├── README.md
├── scripts
│   ├── create-istio-cert.sh
│   ├── deploy.py
│   └── istio.sh
├── terraform
│   ├── gcs
│   └── virtual-machine
└── Vagrantfile
```

## Requirements

To work with Case Study K, the following software is required:

* [kubectl](https://github.com/kubernetes/kubectl)
* [terraform](https://github.com/hashicorp/terraform)
* [helm](https://github.com/helm/Helm)
* [istioctl](https://github.com/istio/istio)
* [vagrant](https://github.com/hashicorp/vagrant)
* [pre-commit](https://github.com/pre-commit/pre-commit) (optional)

## Getting Started

To begin working with Case Study K, you should first install the required software.
You can then clone the repository to your local machine and navigate to the directory.

We use Makefile to make it easier to contribute with the repository
```
local-install                  Deploy the project locally
package                        Create a Helm Chart package for the web-server
deploy                         Deploy the web-server Helm Chart
k-start                        Start minikube cluster
istio                          Deploy and update Istio
cleanup                        Cleans all local generated files
help                           This help.
```

## Helm Chart

Inside the chart file we have the Helm Chart for web-server.
It contain all the kubernetes manifests necessary to deploy the application.

### Labels

The webserver Helm Chart make use of the recomended labels by Kubernetes and Istio.


Kubernetes recomends the following labels to all resources:
```
app.kubernetes.io/name: web-server
app.kubernetes.io/instance: web-server
app.kubernetes.io/version: "0.0.1"
app.kubernetes.io/managed-by: helm
app.kubernetes.io/component: server
app.kubernetes.io/part-of: wordpress

```

The app and version labels add contextual information to the metrics and telemetry that Istio collects.
```
app: web-server
version: "0.0.1"
```

## Terraform

With terraform we can deploy the virtual machine and create the cloud storage bucket to keep the state file for terraform.

The documentation for the terraform is auto generated with the help of pre-commit.
Pre-commit will also 

## Security 
Both the Kubernetes and virtual machine environments have been fortified with several security measures. 
We have configured firewall rules to only allow ports 80 and 443, thereby limiting access to only necessary services.
Additionally, we have implemented SeLinux to enable Apache, thus providing a more secure environment for our web server.
Meaures agains slowloris attack was added both in the k8s and the virtal machine.

In order to prevent slowloris attacks, we have put in place comprehensive measures both in Kubernetes and the virtual machine

For the virtual-machine we added:

```
SSLSessionTickets off
SSLSessionCacheTimeout 300
LimitRequestBody 1048576
LimitRequestFields 100
LimitRequestFieldSize 8190
LimitRequestLine 8190
Timeout 15
KeepAliveTimeout 15
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
SSLUseStapling On
```

Now on the Istio side we have:
```
maxConnections: 100
idleTimeout: 15s
timeout: 15s
  retries:
  attempts: 3
  perTryTimeout: 5s
```

## Testing

We are using Vagrant to spin up virtual machines locally that simulate the target environment.
With Vagrant, we can quickly and easily create and configure virtual machines with the same specifications as our real instances.

To run tests locally, execute `make local-install`. This command performs the following tasks:

* Start minikube with enough resources
* Start Vagrant
* Install Apache with ansible in the Vagrant box
* Deploy Istio in the minikube cluster
* Deploy the web-server

