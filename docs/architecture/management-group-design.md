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

# Subscription Strategy

To maintain clean billing boundaries, quota isolation, and blast-radius containment, our SLZ utilizes a multi-subscription architecture:

| Subscription Name | Purpose | Target Environment |
|-------------------|-----------------------------------|--------------------|
| `sub-core-connectivity` | Hub VNet, Azure Firewall, Bastion | Shared Platform |
| `sub-core-identity` | Centralized identity management | Shared Platform |
| `sub-core-management` | Log Analytics, Sentinel, Automation | Shared Platform |
| `sub-ai-prod` | Production AI Workloads & RAG | Production |
| `sub-ai-nonprod` | Development, Testing, UAT | Dev / Test / UAT |
| `sub-ai-sandbox` | Developer R&D and Prototyping | Sandbox |
