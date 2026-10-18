# Azure AI Secure Landing Zone Architecture Specification

## 1. Executive Summary
This landing zone implements a production-ready, zero-trust infrastructure foundation for hosting enterprise Generative AI and Retrieval-Augmented Generation (RAG) workloads on Azure.

## 2. Architectural Pillars

### A. Network Perimeter & Isolation
* **Zero Public Endpoint Access:** Azure OpenAI, AI Search, Storage Accounts, and Key Vault instances are provisioned with `public_network_access_enabled = false`.
* **Private Link & Private DNS:** All services are accessed exclusively via Private Endpoints bound to subnets in the AI Workload Spoke VNet.
* **Forced Tunneling:** All spoke outbound traffic is routed via User Defined Routes (UDRs) through the Central Azure Firewall in the Hub.

### B. AI Workload Component Architecture
1. **Azure AI Services / OpenAI:** Models deployed via centralized AI Hub/Project resources. Local key authentication is explicitly disabled.
2. **Azure AI Search:** Configured with Semantic Ranker, vector search enabled, and managed identity authorization.
3. **Data Storage:** Azure Blob Storage with Customer-Managed Keys (CMK) support and TLS 1.2 minimum enforcement for storing document corpora.
4. **Key Vault:** Stores encryption keys and operational secrets, locked down via Private Link and RBAC permission model.

### C. Observability & Token Telemetry
* Diagnostic settings on all AI endpoints streaming to a centralized **Log Analytics Workspace**.
* Application Insights tracking model latency, token usage (prompt vs. completion tokens), and client error rates.
