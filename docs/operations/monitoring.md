## 1. Observability Architecture
Every landing zone component streams telemetry into a centralized **Log Analytics Workspace** located in the platform management scope.

### Key Monitored Telemetry Streams:
* **Infrastructure Health:** Azure Firewall throughput, VNet peering packet drops, and Private Endpoint connection states.
* **AI Model Performance:** Response latencies, token consumption rates (split by Prompt Tokens vs. Completion Tokens), and HTTP status codes (e.g., tracking `429 Too Many Requests` for rate-limiting).
* **Security Audits:** Failed authentication attempts, policy violations detected by Azure Policy, and Microsoft Defender for Cloud alerts.

## 2. Cost Governance & Token Budgeting
Generative AI workloads carry dynamic cost structures driven by token usage rather than static compute sizing.
* **Budgets & Alerts:** Azure Cost Management budgets are configured at the AI Landing Zone subscription level with automated webhook alerts firing when monthly token spend hits 50%, 80%, and 100% of threshold.
* **Resource Tagging:** Mandatory CAF tagging policies (`Environment`, `CostCenter`, `Owner`, `DataClassification`) enforced via Terraform and Azure Policy to ensure fine-grained financial chargebacks.
