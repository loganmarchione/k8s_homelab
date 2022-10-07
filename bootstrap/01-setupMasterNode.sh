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
  sudo apt-get update -q > /dev/null
  sudo apt-get upgrade -qy > /dev/null
  sudo apt-get install -qy curl open-iscsi > /dev/null
  sudo apt-get autoremove -qy > /dev/null
}

installK3s() {
  message "STATE: Installing K3s"
  curl -sSL https://get.k3s.io | INSTALL_K3S_VERSION=${VERSION_K3S} sh -s - server --cluster-init --tls-san $(hostname --fqdn)

  message "STATE: Sleeping for 15s"
  sleep 15

  message "STATE: Copying your kubeconfig file"
  mkdir -p $HOME/.kube
  sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  sed -i -e "s/127.0.0.1/$(hostname --fqdn)/g" $HOME/.kube/config
  export KUBECONFIG=$HOME/.kube/config

  message "STATE: Getting cluster info"
  kubectl cluster-info

  #message "STATE: Getting nodes"
  #kubectl get nodes -o wide

  message "STATE: Your kubeconfig is located at:   $HOME/.kube/config"

  if [[ -x "$(command -v /usr/sbin/ufw)" ]]; then
    message "STATE: UFW is installed, opening 6443/tcp"
    sudo ufw allow 6443/tcp > /dev/null
    sudo ufw reload > /dev/null
  else
    message "ERROR: UFW was not found, please make sure 6443/tcp is open"
  fi
}

installHelm() {
  message "STATE: Installing Helm"
  sudo curl -sSL https://get.helm.sh/helm-${VERSION_HELM}-linux-amd64.tar.gz | tar -xz linux-amd64/helm
  sudo mv linux-amd64/helm /usr/local/bin/helm
  sudo chmod +x /usr/local/bin/helm
  rmdir linux-amd64
}

installArgoCD() {
  message "STATE: Installing ArgoCD"
  kubectl apply -f argocd-namespace.yaml
  kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/${VERSION_ARGO}/manifests/install.yaml

  message "STATE: Waiting for ArgoCD"
  kubectl wait --for condition=Ready pods --all --namespace argocd --timeout=90s

  message "STATE: Setting up ArgoCD Traefik IngressRoute"
  cat argocd-ingress.yaml | envsubst | kubectl apply -f -
  cat argocd-no-tls.yaml | envsubst | kubectl apply -f -
  kubectl --namespace argocd rollout restart deployment argocd-server
  kubectl wait --for condition=Ready pods --all --namespace argocd --timeout=90s

  message "STATE: ArgoCD web UI is available at:   https://${ARGO_DOMAIN}"
  argo_pass=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo)
  echo "Username: admin"
  echo "Password: ${argo_pass}"

  #message "STATE: Script will attempt to auto-login to ArgoCD:   https://${ARGO_DOMAIN}"
  #argocd login --grpc-web --insecure --username admin --password ${argo_pass} ${ARGO_DOMAIN}
}

installTools() {
  message "STATE: Installing command-line tools"

  message "STATE: Installing ArgoCD CLI tool"
  sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/${VERSION_ARGO}/argocd-linux-amd64
  sudo chmod +x /usr/local/bin/argocd

  message "STATE: Installing kubeseal CLI tool"
  sudo curl -sSL https://github.com/bitnami-labs/sealed-secrets/releases/download/v${VERSION_KUBESEAL}/kubeseal-${VERSION_KUBESEAL}-linux-amd64.tar.gz | tar -xz kubeseal
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
