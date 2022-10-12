# Flux dependency hierarchy

```mermaid
flowchart TD;
    A["flux-system-helm-repositories (3rd party charts)"]-->B["custom resource definitions (CRDs)"];
    B-->C[infrastructure];
    C-->D[homelab];
```
