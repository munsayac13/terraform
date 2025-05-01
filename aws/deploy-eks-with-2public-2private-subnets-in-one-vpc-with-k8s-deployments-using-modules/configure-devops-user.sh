#!/bin/bash

aws configure --profile devops
aws sts get-caller-identity --profile devops

# create another eks-admin using devops user as a source
cat <<EOF >> ~/.aws/config
[profile associate-devops]
role_arn = arn:aws:iam::YOUR_ACCOUNT_ID:role/eks-admin
source_profile = devops
EOF

aws sts get-caller-identity --profile associate-devops
aws eks update-kubeconfig --name mylocalone_k8s_cluster --region us-east-1 --profile associate-devops

# Verify Successful access to the cluster
kubectl auth can-i "*" "*"
