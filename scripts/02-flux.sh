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

installFlux() {
  message "STATE: Installing Flux"
  curl -sSL https://fluxcd.io/install.sh | FLUX_VERSION=${VERSION_FLUX} sudo -E bash

  message "STATE: Bootstrapping Flux"
  flux bootstrap github \
  --owner=${GITHUB_USER} \
  --repository=${GITHUB_REPO} \
  --branch=${GITHUB_BRANCH} \
  --path=cluster/base \
  --personal
}

userCheck
installFlux

message "STATE: Completed!"
