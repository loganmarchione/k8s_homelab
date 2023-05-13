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
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/k3s.svg"></td>
        <td><a href="https://k3s.io/">K3s</a></td>
        <td>Lightweight Kubernetes</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/traefik-gopher.svg"></td>
        <td><a href="https://traefik.io/">Traefik</a></td>
        <td>Kubernetes Ingress Controller</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/helm.svg"></td>
        <td><a href="https://helm.sh/">Helm</a></td>
        <td>The package manager for Kubernetes</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/fluxcd.svg"></td>
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
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/rancher.svg"></td>
        <td><a href="https://github.com/rancher/local-path-provisioner/">Local Path Provisioner</a></td>
        <td>Local storage based on <code>hostPath</code> and <code>local</code> storage providers</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/certmanager.svg"></td>
        <td><a href="https://cert-manager.io/">cert-manager</a></td>
        <td>X.509 certificate management for Kubernetes</td>
    </tr>
</table>

### `cluster/apps`

The applications that run in my homelab (listed in alphabetical order)

<table>
    <tr>
        <th>Logo</th>
        <th>Name</th>
        <th>Description</th>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/visualstudiocode.svg"></td>
        <td><a href="https://hub.docker.com/r/linuxserver/code-server">Code Server</a></td>
        <td>A Dockerized version of <a href="https://github.com/coder/code-server">code-server</a></td>
    </tr>
    <tr>
         <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/cyberchef.svg"></td>
        <td><a href="https://hub.docker.com/r/mpepping/cyberchef">CyberChef</a></td>
        <td>A Dockerized version of <a href="https://github.com/gchq/CyberChef/">GCHQ's Cyber Swiss Army Knife</a></td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/diagramsdotnet.svg"></td>
        <td><a href="https://hub.docker.com/r/jgraph/drawio">Diagrams.net (aka Draw.io)</a></td>
        <td>Diagram creation</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/focalboard.svg"></td>
        <td><a href="https://hub.docker.com/r/mattermost/focalboard/">Focalboard</a></td>
        <td>Project and task management (Kanban board)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/grafana.svg"></td>
        <td><a href="https://hub.docker.com/r/grafana/grafana-oss">Grafana</a></td>
        <td>Part of the TIG stack (Telegraf, InfluxDB, Grafana)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/graylog.svg"></td>
        <td><a href="https://hub.docker.com/r/graylog/graylog/">Graylog</a></td>
        <td>Open-source log management</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/jellyfin.svg"></td>
        <td><a href="https://github.com/jellyfin/jellyfin-vue/">Jellyfin Vue</a></td>
        <td>Experimental Jellyfin frontend</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/joplin.svg"></td>
        <td><a href="https://hub.docker.com/r/joplin/server">Joplin</a></td>
        <td>Joplin sync server</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/maxmind.svg"></td>
        <td><a href="https://github.com/maxmind/geoipupdate/">MaxMind GeoIP Update</a></td>
        <td>GeoIP database</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/miniflux.svg"></td>
        <td><a href="https://hub.docker.com/r/miniflux/miniflux">Miniflux</a></td>
        <td>Minimalist and opinionated feed reader</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/mongodb-forest-green.svg"></td>
        <td><a href="https://hub.docker.com/_/mongo">MongoDB</a></td>
        <td>NoSQL database</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/navidrome.svg"></td>
        <td><a href="https://github.com/navidrome/navidrome">Navidrome</a></td>
        <td>Modern Music Server and Streamer compatible with Subsonic/Airsonic</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/postgresql.svg"></td>
        <td><a href="https://hub.docker.com/r/dpage/pgadmin4">pgAdmin 4</a></td>
        <td>Management tool for Postgres</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/portainer.svg"></td>
        <td><a href="https://github.com/portainer/portainer">Portainer</a></td>
        <td>Web-based management for Kubernetes</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/docker.svg"></td>
        <td><a href="https://hub.docker.com/_/registry">Registry</a></td>
        <td>Docker image registry</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/docker.svg"></td>
        <td><a href="https://hub.docker.com/r/joxit/docker-registry-ui">Registry UI</a></td>
        <td>Docker image registry UI</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/Templarian/MaterialDesign/master/svg/email-outline.svg"></td>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-postfixrelay">SMTP relay</a></td>
        <td>SMTP (Postfix) relay (my own container image)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/php.svg"></td>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-php-startpage">Startpage</a></td>
        <td>PHP/HTML startpage (my own container image)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/stringis.svg"></td>
        <td><a href="https://hub.docker.com/r/daveperrett/string-is">string.is</a></td>
        <td>A Dockerized version of <a href="https://github.com/recurser/string-is">string.is</a></td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/homelab-svg-assets/main/assets/influx.svg"></td>
        <td><a href="https://hub.docker.com/_/telegraf">Telegraf</a></td>
        <td>Part of the TIG stack (Telegraf, InfluxDB, Grafana)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/traefik-gopher.svg"></td>
        <td><a href="https://doc.traefik.io/traefik/operations/dashboard/">Traefik dashboard</a></td>
        <td>This was already installed, just exposing it with ingress and basic auth</a></td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/ubiquiti.svg"></td>
        <td><a href="https://hub.docker.com/r/ryansch/unifi-rpi">UniFi</a></td>
        <td>A Dockerized version of <a href="https://www.ui.com/download/unifi/">UniFi Controller</a></td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/weaveworks.svg"></td>
        <td><a href="https://github.com/weaveworks/weave-gitops">Weave GitOps</a></td>
        <td>Web-based management for Flux</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/nginx.svg"></td>
        <td><a href="https://hub.docker.com/r/loganmarchione/docker-webdav-nginx">WebDAV</a></td>
        <td>Nginx WebDAV server (my own container image)</td>
    </tr>
    <tr>
        <td><img vertical-align=baseline width="32" src="https://raw.githubusercontent.com/loganmarchione/svg-assets/main/assets/go-blue.svg"></td>
        <td><a href="https://hub.docker.com/r/traefik/whoami/">whoami</a></td>
        <td>Test web app written in Go</td>
    </tr>
</table>

## Installation

See the [README](/scripts/README.md) for more information

## TODO

- [x] Change intervals under `cluster/charts` from 1m to 1h
- [x] [Auto-issue certs](https://cert-manager.io/docs/usage/ingress/) using cert-manager
- [x] Setup [renovatebot](https://github.com/renovatebot/renovate)
- [x] Add [cert-manager CRDs](https://github.com/loganmarchione/k8s_homelab/blob/master/cluster/crds/cert-manager/kustomization.yaml) to renovatebot (discussion [here](https://github.com/renovatebot/renovate/discussions/20118))
- [ ] Setup [Docker digest pinning](https://docs.renovatebot.com/docker/#digest-pinning)
- [ ] Change install bash scripts to Ansible or Terraform (example [here](https://github.com/lieberlois/k3s-hetzner-tf/blob/main/resources.tf#L13-L28))
- [x] Setup yamlint (using [GitHub Actions](https://github.com/ibiqlik/action-yamllint) or just by running `pip3 install yamllint` in the workflow)
