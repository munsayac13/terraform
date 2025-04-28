#!/bin/bash

aws configure set region us-east-1 --profile mylocalone
#OR
#aws configure set profile.mylocalone.region us-east-1

aws configure set aws_access_key_id xxxxxxx --profile mylocalone
aws configure set aws_secret_access_key xxxxxx --profile mylocalone


# GET configured values
aws configure get aws_access_key_id --profile mylocalone
aws configure get aws_secret_access_key --profile mylocalone
#OR
#aws configure get profile.mylocalone.aws_access_key_id
#aws configure get profile.mylocalone.aws_secret_access_key
