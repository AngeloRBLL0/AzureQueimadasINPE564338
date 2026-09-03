#!/bin/bash
RG_TFSTATE="rg-tfstate"
LOCATION="brazilsouth"
STORAGE_ACCOUNT="sttfstatequeimadas564338"
CONTAINER_NAME="tfstate"

az group create --name $RG_TFSTATE --location $LOCATION

az storage account create \
--name $STORAGE_ACCOUNT \
--resource-group $RG_TFSTATE \
--location $LOCATION \
--sku Standard_LRS \
--encryption-services blob

az storage container create \
--name $CONTAINER_NAME \
--account-name $STORAGE_ACCOUNT \
--auth-mode login

az ad sp create-for-rbac \
--name "sp-monitor-queimadas-564338" \
--role Contributor \
--scopes /subscriptions/cadaa8ff-b5c9-4eec-8b1b-35c0ba13909c \
--sdk-auth > azure-credentials.json