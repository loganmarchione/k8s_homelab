#!/bin/bash

# Be safe out there
set -e
set -u
set -o pipefail
IFS=$'\n\t'

source .env

message() {
  echo "######################################################################"
  echo "# $1"
  echo "######################################################################"
}

userCheck() {
  # Fail if running as root
  if [[ $(id -u) -eq 0 ]]; then
    message "ERROR: Can't run as root, exiting"
    exit 1
  else
    message "STATE: Running as $(id -u -n), continuing"
  fi
}

installPackages() {
  message "STATE: Updating system and installing packages"
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y curl open-iscsi
  sudo apt autoremove -y
}

installK3s() {
  message "STATE: Installing K3s"
  curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san $(hostname --fqdn)

  message "STATE: Waiting for K3s to start"
  sleep 15

  message "STATE: Copying your kubeconfig file"
  mkdir -p $HOME/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  sed -i -e "s/127.0.0.1/$(hostname --fqdn)/g" $HOME/.kube/config
  export KUBECONFIG=$HOME/.kube/config

  message "STATE: Getting cluster info"
  kubectl cluster-info

  message "STATE: Getting nodes"
  kubectl get nodes -o wide

  message "STATE: Your kubeconfig is located at:   $HOME/.kube/config"

  if [[ -x "$(command -v /usr/sbin/ufw)" ]]; then
    message "STATE: UFW is installed, opening 6443/tcp"
    sudo ufw allow 6443/tcp
    sudo ufw reload
  else
    message "ERROR: UFW was not found, please make sure 6443/tcp is open"
  fi
}

installHelm() {
  message "STATE: Installing Helm"
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

installArgoCD() {
  message "STATE: Installing ArgoCD"
  kubectl apply -f argocd-namespace.yaml
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

  message "STATE: Waiting for ArgoCD"
  ARGOCDSERVER_POD=$(kubectl get pod -n argocd -o custom-columns=:metadata.name | grep argocd-server)
  kubectl wait pod/${ARGOCDSERVER_POD} -n argocd --for condition=Ready --timeout=120s

  message "STATE: Setting up ArgoCD Traefik IngressRoute"
  cat argocd-ingress.yaml | envsubst | kubectl apply -f -
  kubectl patch deployment -n argocd argocd-server --patch-file argocd-no-tls.yaml

  message "STATE: ArgoCD password is below"
  argo_pass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
  echo "Username: admin"
  echo "Password: ${argo_pass}"

  message "STATE: Script will attempt to auto-login to ArgoCD:   https://${ARGO_DOMAIN}"
  argocd login --grpc-web --insecure --username admin --password ${argo_pass} ${ARGO_DOMAIN}
}

installTools() {
  message "STATE: Installing command-line tools"

  message "STATE: Installing ArgoCD CLI tool"
  sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
  sudo chmod +x /usr/local/bin/argocd

  message "STATE: Installing kubeseal CLI tool"
  sudo curl -sSL https://github.com/bitnami-labs/sealed-secrets/releases/download/v0.18.0/kubeseal-0.18.0-linux-arm64.tar.gz | tar -xz kubeseal
  sudo mv kubeseal /usr/local/bin/kubeseal
  sudo chmod +x /usr/local/bin/kubeseal
}

userCheck
installPackages
installK3s
installHelm
installTools
installArgoCD

message "STATE: Completed! Copy/paste this command into your terminal: export KUBECONFIG=\$HOME/.kube/config"
