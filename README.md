# k8s_homelab

[![yamllint](https://github.com/loganmarchione/k8s_homelab/actions/workflows/yamllint.yml/badge.svg)](https://github.com/loganmarchione/k8s_homelab/actions/workflows/yamllint.yml) [![shellcheck](https://github.com/loganmarchione/k8s_homelab/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/loganmarchione/k8s_homelab/actions/workflows/shellcheck.yml)

A K3s cluster defined as code.

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
        <td><img align=top width="32" src="https://cncf-branding.netlify.app/img/projects/k3s/icon/color/k3s-icon-color.svg"></td>
        <td><a href="https://k3s.io/">K3s</a></td>
        <td>Lightweight Kubernetes</td>
    </tr>
    <tr>
        <td><img align=top width="32" src="https://raw.githubusercontent.com/traefik/traefik/master/docs/content/assets/img/traefik.logo.png"></td>
        <td><a href="https://traefik.io/">Traefik</a></td>
        <td>Kubernetes Ingress Controller</td>
    </tr>
    <tr>
        <td><img align=top width="32" src="https://cncf-branding.netlify.app/img/projects/helm/icon/color/helm-icon-color.svg"></td>
        <td><a href="https://helm.sh/">Helm</a></td>
        <td>The package manager for Kubernetes</td>
    </tr>
    <tr>
        <td><img align=top width="32" src="https://cncf-branding.netlify.app/img/projects/flux/icon/color/flux-icon-color.svg"></td>
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
        <td><img align=top width="32" src="https://raw.githubusercontent.com/rancher/ui/master/public/assets/images/logos/welcome-cow.svg"></td>
        <td><a href="https://github.com/rancher/local-path-provisioner/">Local Path Provisioner</a></td>
        <td>Local storage based on <code>hostPath</code> and <code>local</code> storage providers</td>
    </tr>
    <tr>
        <td><img align=top width="32" src="https://raw.githubusercontent.com/cert-manager/cert-manager/master/logo/logo.png"></td>
        <td><a href="https://cert-manager.io/">cert-manager</a></td>
        <td>X.509 certificate management for Kubernetes</td>
    </tr>
    <tr>
        <td><img align=top width="32" src="https://raw.githubusercontent.com/portainer/portainer/develop/app/assets/images/logo_ico.png"></td>
        <td><a href="https://www.portainer.io/">Portainer</a></td>
        <td>Web-based management for Kubernetes</td>
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
        <td><a href="https://hub.docker.com/r/linuxserver/code-server">Code Server</a></td>
        <td>A Dockerized version of <a href="https://code.visualstudio.com/">VS Code</a></td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/mpepping/cyberchef">CyberChef</a></td>
        <td>A Dockerized version of <a href="https://github.com/gchq/CyberChef/">GCHQ's Cyber Swiss Army Knife</a></td>
    </tr>
    <tr>
        <td><a href="https://www.diagrams.net/">Diagram.net (aka Draw.io)</a></td>
        <td>Diagram creation</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/mattermost/focalboard/">Focalboard</a></td>
        <td>Project and task management (Kanban board)</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/miniflux/miniflux">Miniflux</a></td>
        <td>Minimalist and opinionated feed reader</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/dpage/pgadmin4">pgAdmin 4</a></td>
        <td>Management tool for Postgres</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/_/registry">Registry</a></td>
        <td>Docker image registry</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/joxit/docker-registry-ui">Registry UI</a></td>
        <td>Docker image registry UI</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-postfixrelay">SMTP relay</a></td>
        <td>SMTP (Postfix) relay</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-php-startpage">Startpage</a></td>
        <td>PHP/HTML startpage</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/daveperrett/string-is">string.is</a></td>
        <td>A Dockerized version of <a href="https://github.com/recurser/string-is">string.is</a></td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/ryansch/unifi-rpi">UniFi</a></td>
        <td>A Dockerized version of <a href="https://www.ui.com/download/unifi/">UniFi Controller</a></td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-webdav-nginx">WebDAV</a></td>
        <td>Nginx WebDAV server</td>
    </tr>
    <tr>
        <td><a href="https://hub.docker.com/r/traefik/whoami/">whoami</a></td>
        <td>Test web app written in Go</td>
    </tr>
</table>

## Installation

See the [README](/scripts/README.md) for more information

## TODO

- [x] Change intervals under `cluster/charts` from 1m to 1h
- [x] [Auto-issue certs](https://cert-manager.io/docs/usage/ingress/) using cert-manager
- [ ] Setup [renovatebot](https://github.com/renovatebot/renovate)
- [ ] Add [cert-manager CRDs](https://github.com/loganmarchione/k8s_homelab/blob/master/cluster/crds/cert-manager/kustomization.yaml) to renovatebot
- [ ] Change install bash scripts to Ansible playbooks
- [x] Setup yamlint (using [GitHub Actions](https://github.com/ibiqlik/action-yamllint) or just by running `pip3 install yamllint` in the workflow)
