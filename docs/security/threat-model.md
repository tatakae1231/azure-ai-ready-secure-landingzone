# Azure AI Landing Zone Threat Model & Mitigations

## 1. Overview
This threat model identifies key attack vectors targeting enterprise generative AI and Retrieval-Augmented Generation (RAG) deployments on Azure, detailing the built-in structural mitigations enforced by this landing zone.

---

## 2. Threat Matrix & Mitigations

### Vector A: Data Exfiltration & Man-in-the-Middle (MITM)
* **Threat:** Attackers intercept communications between client applications and Azure OpenAI endpoints or exfiltrate training data/vector stores via public internet exposure.
* **Mitigation:** 
  * Zero public network access (`public_network_access_enabled = false`).
  * All traffic constrained to Azure Private Endpoints within the VNet spoke.
  * Ingress/egress filtered and inspected via central Azure Firewall in the Hub.

### Vector B: Credential Compromise & Unauthorized API Access
* **Threat:** Hardcoded API keys or subscription secrets leaked in source code repositories or environment variables, allowing unauthorized threat actors to consume expensive model tokens.
* **Mitigation:**
  * Local key authentication explicitly disabled (`disable_local_auth = true`) on all Azure AI services.
  * Workloads authenticate strictly via **User-Assigned Managed Identities** mapped to strict Azure RBAC roles (e.g., *Cognitive Services OpenAI User*).

### Vector C: Prompt Injection & Insecure Output Handling (OWASP LLM01 / LLM02)
* **Threat:** Malicious user inputs manipulate model behavior or execute unauthorized commands via downstream tool integrations (Excessive Agency).
* **Mitigation:**
  * Integration of **Azure AI Content Safety** filters inspecting both prompts and completions for hate speech, sexual content, violence, and self-harm.
  * Strict least-privilege scoping on Managed Identities to prevent AI agents from performing destructive actions on enterprise databases or storage accounts.

### Vector D: Storage & Embedding Poisoning (OWASP LLM03)
* **Threat:** Unauthorized modification of vector databases or document corpora stored in Azure Blob Storage, leading to altered RAG responses (hallucination induction).
* **Mitigation:**
  * Storage accounts secured with Private Link, TLS 1.2 enforcement, and Customer-Managed Keys (CMK) via Azure Key Vault.
  * Role-based data plane access (`Storage Blob Data Contributor`) restricted exclusively to verified ingestion pipelines.
