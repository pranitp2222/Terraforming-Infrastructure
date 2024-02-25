#!/bin/bash

IDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')

aws ec2 terminate-instances --instance-ids $IDS