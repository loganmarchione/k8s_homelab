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
  message "STATE: Detecting K3s..."
  if [[ -x "$(command -v /usr/local/bin/k3s)" ]]; then
    message "STATE: K3s is already installed"
    read -p "Do you wish to install it again? (y/n) " yn
    if [[ $yn =~ ^[Yy]$ ]]; then
      :
    else
      message "STATE: Exiting"
      exit 0
    fi
  fi

  message "STATE: Installing K3s"
  curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san $(hostname --fqdn) --disable servicelb

  message "STATE: Waiting for K3s to start"
  sleep 15

  message "STATE: Copying your kubeconfig file"
  mkdir -p $HOME/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  export KUBECONFIG=~/.kube/config

  message "STATE: Getting cluster info"
  kubectl cluster-info

  message "STATE: Getting nodes"
  kubectl get nodes -o wide

  message "STATE: Contents of your kubeconfig file are below (copy/paste this for later)"
  cat $HOME/.kube/config 

  if [[ -x "$(command -v /usr/sbin/ufw)" ]]; then
    message "STATE: UFW is installed, opening 6443/tcp"
    sudo ufw allow 6443/tcp
    sudo ufw reload
  else
    message "ERROR: UFW was not found, please make sure 6443/tcp is open"
  fi
}


userCheck
installPackages
installK3s 

message "STATE: Completed"
