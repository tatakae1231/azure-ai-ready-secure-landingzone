# Azure AI Secure Landing Zone (SLZ) - Architecture Overview

## Introduction
The Azure AI Secure Landing Zone (SLZ) provides an enterprise-ready, scalable, and secure architecture for deploying production-grade artificial intelligence and machine learning workloads, including Azure OpenAI and Retrieval-Augmented Generation (RAG) pipelines.

## Core Architectural Principles
1. **Zero-Trust Network Perimeter:** All PaaS services (Azure OpenAI, Storage Accounts, AI Search, Key Vaults) are isolated using Private Endpoints with public access disabled.
2. **Hub-and-Spoke Topology:** Centralized networking hub managing perimeter security, firewalls, and ingress/egress, paired with dedicated workload spoke landing zones.
3. **Identity-First Security:** Complete elimination of embedded API keys in favor of Microsoft Entra ID and Managed Identities.
4. **Environment Isolation:** Strict logical and physical separation between `dev`, `test`, `uat`, `prod`, and `sandbox` environments.
