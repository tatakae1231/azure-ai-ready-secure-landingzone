# ADR 0001: Hub-and-Spoke Network Topology for Secure AI Workloads

## Context and Problem Statement
Deploying Azure AI Services (Azure OpenAI, Azure AI Search, Azure AI Foundry) into an enterprise environment requires strictly isolated data paths, centralized firewall inspection, and zero public exposure to prevent data leakage and unauthorized API access.

## Decision Drivers
* **Data Exfiltration Risk:** Large Language Models (LLMs) and vector stores contain proprietary corporate enterprise data and ground truth embeddings.
* **Centralized Egress Inspection:** All outbound traffic from AI agents/services to internet APIs must pass through central egress controls.
* **Scalability:** The architecture must scale across multiple application teams/landing zones without duplicating networking overhead.

## Considered Options
1. **Flat / Isolated VNet per Workload:** Each AI workload creates its own standalone VNet with dedicated VPN gateways or direct public endpoints.
2. **Hub-and-Spoke Topology:** A centralized Platform Connectivity VNet (Hub) hosting Firewall/Bastion/DNS, connected via VNet Peering to AI Workload Spoke VNets.
3. **Azure Virtual WAN (vWAN):** Managed mesh networking for large multi-region enterprises.

## Decision Outcome
**Chosen Option:** **Option 2 (Hub-and-Spoke Topology)** for initial landing zone deployment (with a clear upgrade path to vWAN as regions scale).

### Positive Consequences
* Centralized firewall logging and egress filtering via Azure Firewall in the Hub.
* Shared Azure Private DNS Zones hosted in the Hub, reducing duplicate Private Endpoint configuration across spokes.
* Clear isolation between central platform infrastructure and workload-specific landing zones.

### Negative Consequences
* Inter-VNet peering costs for bandwidth between Hub and Spokes.
* Additional operational complexity for managing network security groups (NSGs) and route tables (UDRs).
