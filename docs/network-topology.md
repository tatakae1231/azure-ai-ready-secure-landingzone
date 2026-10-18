# Hub-and-Spoke Network Topology

## Architecture Summary
The network topology implements a classic Hub-and-Spoke architecture connected via Virtual Network (VNet) Peering with remote gateways enabled.

- **Hub VNet (`10.100.0.0/16`):** Houses Azure Firewall, Bastion, and VPN/ExpressRoute Gateway.
- **AI Spoke VNet (`10.101.0.0/16`):** Dedicated to AI workload components, split into compute subnets (`snet-ai-compute`) and private endpoint subnets (`snet-ai-endpoints`).
- **Data Spoke VNet (`10.102.0.0/16`):** Dedicated to data lakes, feature stores, and Azure AI Search.
