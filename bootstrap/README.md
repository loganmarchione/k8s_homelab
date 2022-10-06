# Usage

This is intended to be run on a single-node cluster.

Start by cloning the repo, editing the `.env` file, and bootstrapping the cluster (installing K3s, Helm, and ArgoCD).

```
git clone https://github.com/loganmarchione/k8s_homelab.git
cd k8s_homelab/bootstrap
cp -p .env_sample .env
vim .env
#MAKE YOUR CHANGES IN THE .env FILE
./01-setupMasterNode.sh
```

Next, install applications (this is done via ArgoCD).

```
./02-installApps.sh
```
