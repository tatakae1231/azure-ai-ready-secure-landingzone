# Enterprise Management Group Design

## Hierarchy
Our Azure Management Group (MG) hierarchy aligns with the Microsoft Cloud Adoption Framework (CAF) enterprise scale recommendations:

```text
Tenant Root Group
└── mg-enterprise (Root Enterprise MG)
    ├── mg-platform (Connectivity, Identity, Management subscriptions)
    ├── mg-landingzones
    │   ├── mg-prod (Production workloads)
    │   └── mg-non-prod (Dev, Test, UAT, Sandbox)
    └── mg-sandbox (Isolated experimentation)
