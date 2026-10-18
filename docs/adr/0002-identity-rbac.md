# ADR 0002: Passwordless Authentication via User-Assigned Managed Identities

## Context and Problem Statement
Legacy AI applications frequently rely on persistent API Keys or connection strings stored in application configuration files to access Azure OpenAI and Azure AI Search instances. Stored credentials create significant risk of credential leakage and unauthorized token consumption.

## Decision Drivers
* **Key Rotation Overhead:** Manual or automated primary/secondary key rotations introduce operational complexity and downtime risks.
* **Least Privilege Enforcement:** Standard API Keys grant administrative/full access to the endpoint rather than fine-grained role permissions.
* **Auditability:** Requests authorized via Azure Active Directory (Entra ID) are tied directly to an identity principal in diagnostic logs.

## Decision Outcome
**Chosen Option:** Mandate **User-Assigned Managed Identities** for all application components (web services, container apps, function apps) interacting with Azure AI landing zone resources. Disallow API key authentication across all AI endpoints (`disable_local_auth = true`).

### Fine-Grained RBAC Roles Assigned:
* **Cognitive Services OpenAI User:** Assigned to client applications needing inferencing capability (`gpt-4o`, embeddings).
* **Search Index Data Contributor:** Assigned to ingestion services writing vector data to Azure AI Search.
* **Search Index Data Reader:** Assigned to RAG query services reading vector search indices.

### Positive Consequences
* Zero secrets or persistent keys stored in code repositories or environment variables.
* Automated credential lifetime management handled entirely by Azure Entra ID.
* Fine-grained control over model deployment access.
