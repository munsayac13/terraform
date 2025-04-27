#!/bin/bash

gcloud beta container clusters get-credentials gke-cluster-one --zone {cluster-zone} --project {project}

#OR
#gcloud beta container clusters get-credentials gke-cluster-one --region {cluster-region} --project {project}
