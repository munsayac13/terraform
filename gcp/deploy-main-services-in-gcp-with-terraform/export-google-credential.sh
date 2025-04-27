#!/bin/bash


export GOOGLE_APPLICATION_CREDENTIALS="service-account-credential.json"

terraform init
terraform plan -out tfplan
terraform apply tfplan
