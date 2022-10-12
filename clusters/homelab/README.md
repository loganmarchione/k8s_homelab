# Flux dependency hierarchy

```mermaid
flowchart TD;
    flux-system-->crds;
    crds-->charts;
    charts-->infrastructure;
    infrastructure-->homelab;
```
