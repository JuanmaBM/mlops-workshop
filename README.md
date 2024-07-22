# MLOPS Workhsop (WORK IN PROGRESS)

## Introduction

## Requirements

* Openshift Container Platform 4.14+
* 3 Master Nodes
* At least 3 Worker Nodes
* (Optional) ArgoCD is needed to complete this workshop. An installation script has been provided in this repository, but you can install an instance of ArgoCD by yourself if you prefer.

## Installation

*You can skip Installation section if you are installed an create an instance of ArgoCD*

1. Indentify your Openshift admin credentials (You need an user with cluster-admin permissions) and the API-Server URL
2. Move to setup folder and execute the following command:
```
./install-workshop.sh $USER $PASSWORD $API_SERVER
```
For instance:
```
./install-workshop.sh admin secure_password_for_admin_W3qOpa $API_SERVER
```
3. The RedHat GitOps Operator will be installed, so you just have to wait until the process finish
#TODO: 4. Check if ArgoCD has been installed propertly. Enter to ArgoCD console
Get admin password:
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
Get ArgoCD console URL:
oc get route -n openshift-gitops openshift-gitops-server -o jsonpath='{.spec.host}'
## Getting Start
