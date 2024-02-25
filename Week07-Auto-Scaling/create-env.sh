#!/bin/bash

VPCID=$(aws ec2 describe-vpcs --query "Vpcs[].VpcId")
SUBNET=$(aws ec2 describe-subnets --output=json | jq -r '.Subnets[0,1,2].SubnetId')

BASECONVERT=$(base64 -w 0 < ${6})

#echo $BASECONVERT


aws rds create-db-instance \
    --db-instance-identifier ${13} \
    --db-instance-class db.t3.micro \
    --engine mariadb \
    --master-username wizard \
    --master-user-password cluster168 \
    --allocated-storage 20

echo "========================================================================"

echo "Waiting for DB Instance to get Available......."

echo "========================================================================"

aws rds wait db-instance-available --db-instance-identifier ${13}

echo "========================================================================"

echo "DB Instance ${13} Available"

echo "========================================================================"

aws rds create-db-instance-read-replica \
	--db-instance-identifier ${14} \
	--source-db-instance-identifier ${13}


echo "========================================================================"

echo "Waiting for DB Instance Read Replica to get Available......."

echo "========================================================================"

aws rds wait db-instance-available --db-instance-identifier ${14}

echo "========================================================================"

echo "DB Instance ${14} Read Replica Available"

echo "========================================================================"

aws ec2 create-launch-template \
        --launch-template-name ${12} \
        --version-description AutoScalingVersion1 \
        --launch-template-data "{\"NetworkInterfaces\":[{\"DeviceIndex\": 0,\"AssociatePublicIpAddress\": true,\"Groups\": [\"${4}\"],\"DeleteOnTermination\": true}],\"ImageId\": \"${1}\",\"InstanceType\": \"${2}\",\"KeyName\": \"${3}\",\"UserData\": \"$BASECONVERT\",\"Placement\": {\"AvailabilityZone\": \"${7}\"}}" \
        --region us-east-2

LAUNCHTEMPID=$(aws ec2 describe-launch-templates --output=json | jq -r '.LaunchTemplates[].LaunchTemplateId')

aws elbv2 create-load-balancer --name $8 --subnets $SUBNET --type application --security-groups $4

ELBARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')

aws elbv2 wait load-balancer-available --load-balancer-arns $ELBARN

TARGETARN=$(aws elbv2 create-target-group --name $9 --protocol HTTP --port 80 --target-type instance --vpc-id $VPCID --output=json | jq -r '.TargetGroups[].TargetGroupArn')

aws autoscaling create-auto-scaling-group \
    --auto-scaling-group-name ${11} \
    --launch-template LaunchTemplateId=$LAUNCHTEMPID \
    --target-group-arns $TARGETARN \
    --health-check-grace-period 600 \
    --min-size ${15} \
    --max-size ${16} \
    --desired-capacity ${17} \
    --availability-zones ${7} ${10} \
    --health-check-type EC2

aws elbv2 create-listener --load-balancer-arn $ELBARN --protocol HTTP --port 80 --default-actions Type=forward,TargetGroupArn=$TARGETARN

aws elbv2 wait target-in-service --target-group-arn $TARGETARN

URL=$(aws elbv2 describe-load-balancers --output=json | jq -r  '.LoadBalancers[].DNSName')

echo "========================================================================"

echo "URL for Load Balancer => "

echo $URL

echo "========================================================================"
