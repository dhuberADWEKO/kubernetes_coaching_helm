#!/bin/bash

# Exit on error
set -e

# Define namespace
NAMESPACE="argocd"

# Check if the namespace 'argocd' exists
echo "Checking if namespace $NAMESPACE exists, if not it will be created"
if ! kubectl get namespaces | grep -q "$NAMESPACE"; then
  echo "Namespace does not exist, creating it ..."
  kubectl create namespace "$NAMESPACE"
  echo "Namespace $NAMESPACE created!"
fi

# Apply Custom Resource Definitions
echo "Applying CRDs..."
kubectl apply -f crds.yaml

# Apply ConfigMaps
echo "Applying ConfigMaps to namespace $NAMESPACE..."
kubectl apply -f argocd-configmaps.yaml -n $NAMESPACE

# Apply Secrets
echo "Applying Secrets to namespace $NAMESPACE..."
kubectl apply -f argocd-secrets.yaml -n $NAMESPACE

# Apply All Resources
echo "Applying all resources to namespace $NAMESPACE..."
kubectl apply -f argocd-all-resources.yaml -n $NAMESPACE

echo "Restoration complete!"
