# Operational Deployment Guide

## 1. Prerequisites
Before running Terraform deployments or triggering CI/CD pipelines, ensure you have:
* An **Azure Subscription** with permissions to create Management Groups, Service Principals, and Networking components.
* **Terraform CLI** (version `1.8.x` or higher).
* An Azure Storage Account pre-configured to act as the remote Terraform state backend.

## 2. Initial Setup & Backend Configuration
1. Clone the repository:
   ```bash
   git clone [https://github.com/](https://github.com/)<your-org>/azure-ai-slz.git
   cd azure-ai-slz/scripts
