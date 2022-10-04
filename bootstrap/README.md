# Usage

This is intended to be run on a single-node cluster.

```
git clone https://github.com/loganmarchione/k8s_homelab.git
cd k8s_homelab/bootstrap
cp -p .env_sample .env
vim .env
#MAKE YOUR CHANGES IN THE .env FILE
./setupMasterNode.sh
```