# AI Platform & Model Serving Architecture

## Components
- **Azure OpenAI Service:** Configured with enterprise quotas, deployed behind private endpoints, and governed by custom Content Safety / RAI (Responsible AI) policies.
- **Model Deployments:** Standardized deployments for core enterprise models (`gpt-4o`, `gpt-4o-mini`, `text-embedding-3-small`).
- **RAG & Vector Grounding:** Integration with Azure AI Search and ADLS Gen2 Hierarchical Namespaces (ADLS Gen2) for secure semantic retrieval.
