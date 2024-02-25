#!/bin/bash

IDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')
LOADBALANCERARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')
LISTENERARN=$(aws elbv2 describe-listeners --load-balancer-arn $LOADBALANCERARN --output=json | jq -r '.Listeners[].ListenerArn')
TARGETGROUP=$(aws elbv2 describe-target-groups --output=json | jq -r '.TargetGroups[].TargetGroupArn')

aws elbv2 delete-listener --listener-arn $LISTENERARN
aws elbv2 delete-load-balancer --load-balancer-arn $LOADBALANCERARN
aws elbv2 delete-target-group --target-group-arn $TARGETGROUP
aws ec2 terminate-instances --instance-ids $IDS