# Usage

This is intended to be:
- run on a single-node cluster
- executed on the single node (you'll need sudo access)
- run on amd64 hardware

Start by cloning the repo, editing the `.env` file, and bootstrapping the cluster (installing K3s, Helm, etc...).

```
git clone https://github.com/loganmarchione/k8s_homelab.git
cd k8s_homelab/scripts
cp -p .env_sample .env
vim .env
#MAKE YOUR CHANGES IN THE .env FILE
./01-setupMasterNode.sh
```
