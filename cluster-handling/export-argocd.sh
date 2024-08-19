#!/bin/bash

# Exit on error
set -e

# Define namespace
NAMESPACE="argocd"

# Export Custom Resource Definitions
echo "Exporting CRDs..."
kubectl get crd -o yaml > crds.yaml

# Export ConfigMaps
echo "Exporting ConfigMaps from namespace $NAMESPACE..."
kubectl get configmap -n $NAMESPACE -o yaml > argocd-configmaps.yaml

# Export Secrets
echo "Exporting Secrets from namespace $NAMESPACE..."
kubectl get secret -n $NAMESPACE -o yaml > argocd-secrets.yaml

# Export All Resources
echo "Exporting all resources from namespace $NAMESPACE..."
kubectl get all -n $NAMESPACE -o yaml > argocd-all-resources.yaml

echo "Export complete!"
