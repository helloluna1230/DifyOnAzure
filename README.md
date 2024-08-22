# Dify Deploy on Azure
## Overview
this is a simple example of how to deploy a Dify project on Azure using terraform.
## Topology
**Front-end access:**
application Gateway 
**Back-end components:**
Azure Kubernetes Service (AKS) with the following components:
业务服务 web，api，worker 
基础服务 sandbox，ssrf_proxy 

**Database and vectordb components:**
Azure Database for PostgreSQL
**Cache components:**
Azure Cache for Redis

Before you provision Dify, please check and set the variables in dev-variables.tfvars file.

## Deploy
```bash
terraform init
terraform plan dev-plan -var-file=./enviroment/dev-variables.tfvars
terraform apply dev-plan
```