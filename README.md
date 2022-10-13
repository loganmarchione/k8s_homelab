# k8s_homelab

## Stack

### Core

The core components of the cluster

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img width="32" src="https://cncf-branding.netlify.app/img/projects/k3s/icon/color/k3s-icon-color.svg"></td>
        <td><a href="https://k3s.io/">K3s</a></td>
        <td>Lightweight Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://raw.githubusercontent.com/traefik/traefik/master/docs/content/assets/img/traefik.logo.png"></td>
        <td><a href="https://traefik.io/">Traefik</a></td>
        <td>Kubernetes Ingress Controller</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cncf-branding.netlify.app/img/projects/helm/icon/color/helm-icon-color.svg"></td>
        <td><a href="https://helm.sh/">Helm</a></td>
        <td>The package manager for Kubernetes</td>
    </tr>
    <tr>
        <td><img width="32" src="https://cncf-branding.netlify.app/img/projects/flux/icon/color/flux-icon-color.svg"></td>
        <td><a href="https://fluxcd.io/">Flux CD</a></td>
        <td>Continuous delivery solutions for Kubernetes </td>
    </tr>
</table>

### `cluster/infrastructure`

The infrastructure that everything else depends on

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img width="32" src="https://raw.githubusercontent.com/cert-manager/cert-manager/master/logo/logo.png"></td>
        <td><a href="https://cert-manager.io/">cert-manager</a></td>
        <td>X.509 certificate management for Kubernetes</td>
    </tr>
</table>

### `cluster/apps`

The applications that run in my homelab (listed in alphabetical order)

<table>
    <tr>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><a href="https://www.diagrams.net/">Diagram.net (aka Draw.io)</a></td>
        <td>Diagram creation</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/traefik/whoami/">whoami</a></td>
        <td>Test web app written in Go</td>
    </tr>
</table>

## Installation

See the [README](/scripts/README.md) for more information

## TODO

- [ ] Change intervals under `cluster/charts` from 1m to 1h
- [ ] [Auto-issue certs](https://cert-manager.io/docs/usage/ingress/) using cert-manager
