#!/bin/bash

# Exit on error
set -e

# Apply Custom Resource Definitions
echo "Applying CRDs..."
kubectl apply -f crds.yaml

# Apply ConfigMaps
echo "Applying ConfigMaps..."
kubectl apply -f argocd-configmaps.yaml

# Apply Secrets
echo "Applying Secrets..."
kubectl apply -f argocd-secrets.yaml

# Apply All Resources
echo "Applying all resources..."
kubectl apply -f argocd-all-resources.yaml

echo "Restoration complete!"
