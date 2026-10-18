# Private Connectivity & DNS Resolution

## Resolution Strategy
All Azure PaaS services are bound to private endpoints within workload subnets. Centralized Private DNS Zones (`privatelink.openai.azure.com`, `privatelink.blob.core.windows.net`, `privatelink.search.windows.net`) are linked to the hub and spoke VNets to ensure seamless internal name resolution without traversing public DNS resolvers.
