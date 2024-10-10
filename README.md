# Kubernetes, ArgoCD, and HELM Training Repository

Welcome to the Kubernetes, ArgoCD, and HELM training repository! This repository is designed to provide resources, scripts, and instructions to help you set up and manage Kubernetes environments with ArgoCD and HELM. Whether you're running on Windows (using WSL2) or Mac, this repository will guide you through the necessary steps.

## Topics Covered

### **HELM Chart for Coaching**
This section contains a HELM chart specifically designed for coaching purposes. It will help you understand the basic structure and components of HELM charts and how they can be customized to suit specific application needs.

### **Prerequisites**
   - **WSL2 (Windows only)**
     - Ensure that you have WSL2 installed on your Windows machine for optimal compatibility with Docker and Kubernetes.
   - **Docker Desktop**
     - Docker Desktop is required to manage containers and Kubernetes clusters locally.
   - **Homebrew (Mac only)**
     - Ensure Homebrew is installed as follows:
       ```bash
       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
       ```
   - **Minikube Kubernetes Cluster (Mac only)**
     - For the case, that the built-in Kubernetes cluster in Docker Desktop is NOT starting on your Mac, please just install a default Minikube single-node cluster via Homebrew:
       ```bash
       brew install minikube
       minikube start
       ```
     - This will automatically be detected within Docker Desktop as 'mini-kube' and argoCD and HELM can be installed straightforward without the need of any further adaptions  

### **Installing HELM**
   Detailed instructions will guide you through the process of installing HELM on both Windows (using WSL2) and Mac.

####   **Windows Installation (WSL2)**
   Install using the official GitHub Script:
   ```bash
   curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
   chmod 700 get_helm.sh
   ./get_helm.sh
   helm version
   ```

####   **Mac Installation**
  Install using the Homebrew package: 
  ```bash
  brew install helm
  helm version
  ```

### **Installing a local ArgoCD Instance**
   Detailed instructions will guide you through the process of installing argoCD locally on both Windows (using WSL2) and Mac.

####   **Windows Installation (WSL2)**
   Install using the official GitHub Script:
   ```bash
   VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
   curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
   sudo mv argocd-linux-amd64 /usr/local/bin/argocd
   sudo chmod +x /usr/local/bin/argocd
   argocd version
   ```
   
   Apply the necessary Kubernetes procedure:
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   kubectl port-forward svc/argocd-server -n argocd 8090:443
   ```
   
   Keep the connection open (!) and start a second terminal:
   ```bash
   kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
   echo "This is your password: "
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```

   Access the GUI via https://localhost:8090 - Standard username is 'admin'

####   **Mac Installation**
   Install using Homebrew:
   ```bash
   brew install argocd
   argocd version
   ```
   
   Apply the necessary Kubernetes procedure:
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   kubectl port-forward svc/argocd-server -n argocd 8090:443
   ```

   Keep the connection open (!) and start a second terminal:
   ```bash
   kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
   echo "This is your password: "
   kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
   ```

   Access the GUI via https://localhost:8090 - Standard username is 'admin'


### **Setup of ArgoCD application**
First create a new namespace in Kubernetes where we will deploy our HELM chart:
```bash
kubectl create namespace coaching
```

Now we can start setting up a **new application** in our local argoCD instance:
- Application Name: helm-demo 
- Project Name: default
- Sync Policy: Manual (will be adapted later)
- Repository URL: https://github.com/dhuberADWEKO/kubernetes_coaching_helm.git
- Revision: master
- Path: .
- Cluster URL: https://kubernetes.default.svc (will be automatically set to 'in cluster')
- Namespace: coaching
- Values files: values.yaml

### **Scripts for Efficient Management of Local ArgoCD Instances**
You can check the **cluster-handling** folder for bash scripts enabling a secure export and restore procedure for the argoCD instance in the local Kubernetes namespace.

### **Scripts for GitHub/BitBucket Runner**
You can check the **.github/workflows** folder for scripts improving the overall repository handling in terms of code consistency and HELM chart structure verification.

## Getting Started

Please review the prerequisites and ensure that your environment is properly set up before proceeding with the installation instructions. The placeholders will be updated with detailed steps in the near future.

## Contributing

Contributions to this repository are welcome! If you have suggestions, improvements, or additional scripts that could benefit others, please feel free to submit a pull request.

## Attribution

This project utilizes the External Secrets library to manage secrets. It is licensed under the Apache 2.0 License. For more information, please refer to the [External Secrets GitHub repository](https://github.com/external-secrets/external-secrets).

## License

This repository is licensed under the MIT License and the Apache 2.0 License. For more details, see the [LICENSE](LICENSE) and [NOTICE](NOTICE) files. This project uses the External Secrets library, which is licensed under the Apache 2.0 License. For more information, please visit the [External Secrets GitHub repository](https://github.com/external-secrets/external-secrets).
