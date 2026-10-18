# Data Flow & Security Model

1. **User Request:** Client queries application hosted in AI spoke compute subnet via internal load balancer or API Gateway.
2. **Secure Ingress:** Traffic flows through Azure Firewall inspection.
3. **PaaS Interaction:** Application securely queries Azure OpenAI and ADLS Gen2 via private endpoints over internal virtual network routing. No traffic exits to the public internet.
