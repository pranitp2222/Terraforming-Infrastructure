#!/bin/bash

VPCID=$(aws ec2 describe-vpcs --query "Vpcs[].VpcId")
SUBNET=$(aws ec2 describe-subnets --output=json | jq -r '.Subnets[1,2].SubnetId')

aws ec2 run-instances --image-id $1 --instance-type $2 --key-name $3 --security-group-ids $4 --count ${5} --user-data file://$6 --placement AvailabilityZone=$7

INSTANCEIDS=$(aws ec2 describe-instances --query 'Reservations[*].Instances[?State.Name==`running`].InstanceId')

aws elbv2 create-load-balancer --name $8 --subnets $SUBNET --type application --security-groups $4
ELBARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')

aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN
TARGETARN=$(aws elbv2 create-target-group --name $9 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --output=json | jq -r '.TargetGroups[].TargetGroupArn')

for IIDS in $INSTANCEIDS;
do aws elbv2 register-targets --target-group-arn $TARGETARN --targets Id=$IIDS;
done

aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

aws elbv2 wait target-in-service --target-group-arn $TARGETARN

URL=$(aws elbv2 describe-load-balancers --output=json | jq -r  '.LoadBalancers[].DNSName')

echo "========================================================================"

echo "URL for Load Balancer => "
echo $URL

echo "========================================================================"