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
    message "ERROR: Can't run as root" >> "$logfile"
    exit 1
  else
    message "STATE: Running as $(id -u -n)\n"
  fi

}

installPackages() {
  message "STATE: running installPackages"

  sudo apt update && sudo apt upgrade -y

  sudo apt install -y curl

  sudo apt autoremove -y
}

installK3s() {

  message "STATE: Detecting K3s...\n"
  if [[ -x "$(command -v /usr/local/bin/k3s)" ]]; then
    read -p "Continue (y/n)?" CONT
    if [ "$CONT" = "y" ]; then
      echo "yaaa";
      exit 1
      #   message "running installK3s"
      #   curl -sfL https://get.k3s.io | sh -s - server --cluster-init --tls-san $hostname --disable servicelb
      #   sleep 10
    else
      echo "booo";
      exit 1
    fi

  message "STATE: Getting cluster info"
  kubectl cluster-info

  message "STATE: Getting nodes"
  kubectl get nodes -o wide

  message "STATE: Contents of your kubeconfig file are below (copy/paste this for later)\n"
  cat /etc/rancher/k3s/k3s.yaml

  if [[ -x "$(command -v ufw)" ]]; then
    message "STATE: UFW is installed, opening 6443/tcp\n"
    sudo ufw allow 6443/tcp
    sudo ufw reload
  else
    message "ERROR: UFW was not found, please make sure 6443/tcp is open\n"
  fi
}


userCheck
installPackages
#installK3s 

message "STATE: Completed"