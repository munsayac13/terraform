#!/bin/bash

terraform init
terraform import module.instances.google_compute_instance.mylocalone_instance_1 INSTANCE_ID
terraform import module.instances.google_compute_instance.mylocalone_instance_2 INSTANCE_ID
