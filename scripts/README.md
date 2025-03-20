# Assumptions

Some assumptions I'm making...

- This is intended to be run on a single-node cluster (i.e., master and worker on same node)
- These scripts are intended to be executed on the single node itself (you'll need sudo access)
- This will only run on amd64 hardware
- This will **not** "just work" out of the box
  - The database server for some applications (e.g., Gitea, Miniflux, etc...) is external to all of this and needs to be created
  - DNS needs to be setup

Start by cloning the repo, editing the `.env` file, and bootstrapping the cluster (installing K3s, Helm, etc...).

## Setup

### Prerequisites

- You've created a GitHub [personal access token](https://github.com/settings/tokens) with the following permissions:
  - all under `repo`
  - all under `admin:public_key`

### K3s

Starting by cloning the repo, editing a few variables, and then installing K3s.

```
git clone https://github.com/loganmarchione/k8s_homelab.git
cd k8s_homelab/scripts
cp -p .env_sample .env
vim .env
#MAKE YOUR CHANGES IN THE .env FILE
./01-setupMasterNode.sh
```

At this point, you should be able to run the commands below. If so, K3s is up and running!

```
export KUBECONFIG=$HOME/.kube/config
kubectl get nodes -o wide
```

You can find your kubeconfig file and copy/paste it to your local workstation for accessing your cluster remotely.

```
cat $HOME/.kube/config
```

### Flux

Now, create a series of secrets.

⚠️ WARNING ⚠️

Keep in mind that these secrets will be in your shell history and clipboard (you should clear both). Obviously replace the secrets (don't copy/paste directly).

```
kubectl create secret generic cluster-secret-vars \
  --namespace=flux-system \
  --from-literal=SECRET_INTERNAL_DOMAIN_NAME=your.domain.com \
  --from-literal=SECRET_LETS_ENCRYPT_EMAIL=name@email.com \
  --from-literal=FOCALBOARD_DB_HOST=hostname \
  --from-literal=FOCALBOARD_DB_USER=admin \
  --from-literal=FOCALBOARD_DB_PASS=super_secret_password_goes_here \
  --from-literal=FOCALBOARD_DB_NAME=DBName

kubectl create secret generic cluster-user-auth \
  --namespace flux-system \
  --from-literal=username=admin \
  --from-literal=password='bcrypt_password_hash_goes_here'

kubectl create secret generic traefik-secret-vars \
  --namespace=kube-system \
  --type=kubernetes.io/basic-auth \
  --from-literal=username=admin \
  --from-literal=password=super_secret_password_goes_here

kubectl create secret generic cloudflare-api-token-secret \
  --namespace=cert-manager \
  --from-literal=api-token='token_goes_here'

kubectl create secret generic pgadmin-secret-vars \
  --namespace=pgadmin4 \
  --from-literal=PGADMIN_DEFAULT_EMAIL=name@email.com \
  --from-literal=PGADMIN_DEFAULT_PASSWORD=super_secret_password_goes_here

kubectl create secret generic miniflux-secret-vars \
  --namespace=miniflux \
  --from-literal=DATABASE_URL='postgres://db_user:db_password@db.your.domain.com:5432/db_name?sslmode=verify-full' \
  --from-literal=ADMIN_USERNAME=admin \
  --from-literal=ADMIN_PASSWORD=super_secret_password_goes_here
```

Verify the secrets were created.

```
kubectl get secret --all-namespaces
```

Bootstrap Flux (this will install Flux and **everything** else).

```
./02-flux.sh
```

## Verification

### Flux

Flux bootstraps in the order below (based off of the [dependencies](https://fluxcd.io/flux/components/kustomize/kustomization/#kustomization-dependencies) I've setup).

```mermaid
flowchart TD;
    A["flux-system (core of flux)"]-->B["namespaces"]
    B-->C["charts (3rd party charts)"];
    C-->D["crds (custom resource definitions)"];
    D-->E[infrastructure];
    E-->F[apps];
```

Wait a few seconds, then run the command below (it will take a few minutes for everything to show `True`).

```
kubectl get kustomization -n flux-system
```

If you need to give it a kick in the ass, use this.

```
flux reconcile source git flux-system
```

### StorageClass

There is a custom storage class called `local-path-customized` based on Rancher's [local-path-provisioner](https://github.com/rancher/local-path-provisioner). It has the following additions:

```
reclaimPolicy: Retain
allowVolumeExpansion: true
```

You can view the storage class below.

```
kubectl get storageclass
```

The location of the files are `/var/lib/rancher/k3s/storage`

```
ls -la /var/lib/rancher/k3s/storage
```

### cert-manager

After a few minutes, make sure that Let's Encrypt registered a `ClusterIssuer` and `secret` for both `production` and `staging`.

```
kubectl get clusterissuer -n cert-manager
kubectl get secret -n cert-manager
```

A few minutes, you should see certificates appear (it will take up to five minutes for everything to show `True`).

```
kubectl get certificate --all-namespaces
```

If the certificates are not issuing, use the commands below to troubleshoot.

```
kubectl get certificaterequest --all-namespaces
kubectl get order --all-namespaces
```

If you need to renew all certificates when you make a a change (e.g., changing DNS solvers)

```
cmctl renew --all --all-namespaces
```

### Kubernetes dashboard

Run the command below to get the bearer token for the Kubernetes dashboard

```
kubectl get secret admin-user -n kubernetes-dashboard -o jsonpath="{.data.token}" | base64 -d
```
