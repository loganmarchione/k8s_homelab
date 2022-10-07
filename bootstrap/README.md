# Usage

This is intended to be:
- run on a single-node cluster
- run on amd64 hardware

Start by cloning the repo, editing the `.env` file, and bootstrapping the cluster (installing K3s, Helm, and ArgoCD).

```
git clone https://github.com/loganmarchione/k8s_homelab.git
cd k8s_homelab/bootstrap
cp -p .env_sample .env
vim .env
#MAKE YOUR CHANGES IN THE .env FILE
./01-setupMasterNode.sh
```

Next, install infrastructure (this is done via ArgoCD).

```
./02-installInfrastructure.sh
```

Next, install main applications (this is done via ArgoCD)

 ```
 ./03-installMain.sh
 ```
