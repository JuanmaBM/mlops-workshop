#!/bin/bash

# Function to check if the operator is ready
check_operator_status() {

    if [[ $(oc get pods -n openshift-operators -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') == "True" ]]; then
        echo "Operator openshift-gitops-operator is ready."
    else
        echo "Operator openshift-gitops-operator is not ready. Waiting..."
        sleep 30
        check_operator_status
    fi
}

# Check if both username and password are provided as arguments
if [ $# -ne 3 ]; then
    echo "Usage: $0 <username> <password> <apiserver>"
    exit 1
fi

username=$1
password=$2
api_server=$3

echo "======================================"
echo "Logging into Openshift"
echo "======================================"
oc login -u $username -p $password --server=$api_server

echo "Installing Openshift GitOps operator"
oc apply -f redhat-openshift-gitops.yaml
check_operator_status

echo "Configuring operator permissions in the cluster"
oc apply -f argocd-cluster-role.yaml

echo "Waiting one minute before create ArgoCD apps in order to complete ArgoCD componentn reconcilliation"
sleep 60

# FIXME: This step will be performed in the workshop
echo "Creating ArgoCD applications"
oc apply -k ../gitops/argocd
