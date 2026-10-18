# Compliance Control Mapping Matrix

| Control Objective | Standard / Framework | Landing Zone Implementation |
| :--- | :--- | :--- |
| **Data Encryption at Rest** | ISO 27001 (A.10) / SOC 2 | All storage accounts and AI search indexes encrypted using Microsoft-managed or Customer-Managed Keys (CMK). |
| **Data Encryption in Transit** | NIST SP 800-53 (SC-8) | TLS 1.2 minimum enforced across all endpoints; private link encapsulation within Azure backbone network. |
| **Access Control & Least Privilege** | SOC 2 (CC6.1) / NIST (AC-6) | Entra ID RBAC + Managed Identities. Zero shared credentials or long-lived API keys. |
| **Audit Logging & Telemetry** | ISO 27001 (A.12) / SOC 2 | Centralized diagnostic settings streaming all control and data plane logs to a dedicated Log Analytics Workspace. |
| **Network Segmentation** | NIST SP 800-53 (SC-7) | Hub-and-spoke virtual network topology with Azure Firewall inspection and zero public IP exposure. |
