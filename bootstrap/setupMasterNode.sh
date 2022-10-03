#!/bin/bash

# Be safe out there
set -e
set -u
set -o pipefail
IFS=$'\n\t'

# Set generic variables
hostname=$(uname -n)

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
  sudo apt install -y curl
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

  message "STATE: Contents of $HOME/.kube/config file are below (copy/paste this for later)"
  cat $HOME/.kube/config 

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

  curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
  chmod 700 get_helm.sh
  ./get_helm.sh
  rm get_helm.sh
}

installArgoCD() {
  message "STATE: Installing ArgoCD"

  kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
}

userCheck
installPackages

 message "STATE: Detecting K3s..."
 if [[ -x "$(command -v /usr/local/bin/k3s)" ]]; then
   message "STATE: K3s is already installed"
   read -p "Do you wish to install it again? (y/n) " yn
   if [[ $yn =~ ^[Yy]$ ]]; then
     installK3s
     installHelm
     installArgoCD
     message "STATE: Completed! Copy/paste this command into your terminal: export KUBECONFIG=\$HOME/.kube/config"
   else
     message "STATE: Exiting"
     exit 0
   fi
 fi
