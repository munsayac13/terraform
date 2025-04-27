#!/bin/bash

# Create via gcloud
gcloud iam service-accounts keys create service-account-credential.json --iam-account={iam-account-email}


# OR 
# Create service account via terraform
# terraform plan -target=google_service_account_key.kubernetes_service_account_key
