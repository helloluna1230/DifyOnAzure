# Dify Deploy on Azure
## Overview
this is a simple example of how to deploy a Dify project on Azure using terraform.
## Topology
Front-end access:

Application Gateway 
Back-end components:

web -> Azure Kubernetes Service
api -> Azure Kubernetes Service
worker -> Azure Kubernetes Service
sandbox -> Azure Kubernetes Service
ssrf_proxy -> Azure Kubernetes Service
db -> Azure Database for PostgreSQL
vectordb -> Azure Database for PostgreSQL
redis -> Azure Cache for Redis

Before you provision Dify, please check and set the variables in dev-variables.tfvars file.
