# Disaster Recovery & Business Continuity (BCDR)

- **State Management:** Terraform state files are stored in versioned, geo-replicated Azure Storage accounts with soft-delete enabled.
- **Production High Availability:** Production AI workloads utilize paired Azure regions (`eastus2` primary, `westus3` secondary) with geo-redundant storage (`GRS`) and multi-region deployment capabilities.
