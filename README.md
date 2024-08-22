# Dify on Azure
## Overview
this is a simple example of how to deploy a Dify project on Azure.
## Topology
![Topology](./images/image.png)

Before you provision Dify, please check and set the variables in dev-variables.tfvars file.

## Deploy
```bash
terraform init
terraform plan dev-plan -var-file=./enviroment/dev-variables.tfvars
terraform apply dev-plan
```