#!/bin/bash

# Be safe out there
set -e
set -u
set -o pipefail
IFS=$'\n\t'

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

installPackages() {
  message "running installPackages"

  sudo apt update && sudo apt upgrade -y

  sudo apt install -y curl wget
}

installK3s() {
  message "running installK3s"

  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server  --cluster-init  --token $K3S_TOKEN --tls-san k8s-0-cp --tls-san k8s-1-cp --tls-san k8s-2-cp-hp7 --tls-san rancher.rsr.net --disable servicelb --disable traefik --disable local-storage --flannel-backend=host-gw --node-label k3s-upgrade=enabled " sh -
  curl -sfL https://get.k3s.io | sh -s - server --disable servicelb

  kubectl get nodes -o wide
}

installPackages

message "STATE: Completed"