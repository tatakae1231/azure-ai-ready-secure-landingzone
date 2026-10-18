# Identity & Access Management (IAM) Architecture

## Principles
- **Passwordless Authentication:** Service-to-service communication is authenticated exclusively via Microsoft Entra ID Managed Identities (System-Assigned and User-Assigned).
- **Least Privilege RBAC:** Terraform and runtime modules enforce granular Azure RBAC assignments (e.g., `Storage Blob Data Contributor`, `Key Vault Secrets User`) rather than broad contributor roles.
- **Local Auth Disabled:** All Azure OpenAI, Storage, and AI Search accounts have local key authentication disabled (`local_auth_enabled = false`).
