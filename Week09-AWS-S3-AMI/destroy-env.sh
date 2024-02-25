#!/bin/bash

DBNAME=$(aws rds describe-db-instances --output=json | jq -r '.DBInstances[0].DBInstanceIdentifier')
DBREP=$(aws rds describe-db-instances --output=json | jq -r '.DBInstances[1].DBInstanceIdentifier')

aws rds wait db-instance-available --db-instance-identifier $DBREP

aws rds delete-db-instance --db-instance-identifier $DBNAME --skip-final-snapshot

echo "========================================================================"

echo "Waiting for DB Instance to get Deleted......."

echo "========================================================================"

aws rds wait db-instance-deleted --db-instance-identifier $DBNAME

echo "========================================================================"

echo "DB got Deleted"

echo "========================================================================"

aws rds delete-db-instance --db-instance-identifier $DBREP --skip-final-snapshot

echo "========================================================================"

echo "Waiting for DB Read Replica to get Deleted......."

echo "========================================================================"

aws rds wait db-instance-deleted --db-instance-identifier $DBREP

echo "========================================================================"

echo "DB Read Replica Deleted......."

echo "========================================================================"


echo "========================================================================"

S3BUCKETS=$(aws s3api list-buckets --query "Buckets[].Name")

echo "S3 Objects  Deleting......."

echo "========================================================================"

#S3BUCKETOBJ=$(aws s3api list-objects --bucket s3-bucket-raw-ppatil19 --output=json | jq -r '.Contents[].Key')

for BUCKETS in $S3BUCKETS;
do
	S3BUCKETOBJ=$(aws s3api list-objects --bucket $BUCKETS --output=json | jq -r '.Contents[].Key')
	for OBJKEY in $S3BUCKETOBJ;
	do aws s3api delete-object --bucket $BUCKETS --key $OBJKEY
	done
done

echo "========================================================================"

echo "S3 Objects  Deleted......."

echo "========================================================================"

echo "S3 BUCKET Deleting......."

echo "========================================================================"

for BUCKETS in $S3BUCKETS;
do
	aws s3api delete-bucket --bucket $BUCKETS --region us-east-2
	echo "S3 BUCKET $BUCKETS waiting to Deleted......."
       	aws s3api wait bucket-not-exists --bucket $BUCKETS
	echo "S3 BUCKET $BUCKETS Deleted......."
done

echo "========================================================================"
echo "ALL S3 BUCKETS Deleted"

echo "========================================================================"


SCALINGNAME=$(aws autoscaling describe-auto-scaling-groups --output=json | jq -r '.AutoScalingGroups[].AutoScalingGroupName')
TARGETGROUP=$(aws elbv2 describe-target-groups --output=json | jq -r '.TargetGroups[].TargetGroupArn')
INSTANCEIDS=$(aws ec2 describe-instances --query 'Reservations[*].Instances[?State.Name==`running`].InstanceId')
IDS=$(aws ec2 describe-instances --output=json | jq -r '.Reservations[].Instances[].InstanceId')
LOADBALANCERARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')
LTNAME=$(aws ec2 describe-launch-templates --output=json | jq -r '.LaunchTemplates[].LaunchTemplateId')
ELLISTNERARN=$(aws elbv2 describe-listeners --load-balancer-arn $LOADBALANCERARN --output=json | jq -r '.Listeners[].ListenerArn')
LOADBALANCERARN=$(aws elbv2 describe-load-balancers --output=json | jq -r '.LoadBalancers[].LoadBalancerArn')


for IIDS in $INSTANCEIDS;
do aws elbv2 deregister-targets --target-group-arn $TARGETGROUP --targets Id=$IIDS
done

aws elbv2 delete-listener --listener-arn $ELLISTNERARN

aws autoscaling update-auto-scaling-group --auto-scaling-group-name $SCALINGNAME --min-size 0 --max-size 0 --desired-capacity 0

aws autoscaling detach-load-balancer-target-groups --auto-scaling-group-name $SCALINGNAME --target-group-arns $TARGETGROUP

for IDIN in $INSTANCEIDS;
do aws autoscaling detach-instances --instance-ids $IDIN --auto-scaling-group-name $SCALINGNAME --should-decrement-desired-capacity
done

aws autoscaling suspend-processes --auto-scaling-group-name $SCALINGNAME

aws ec2 delete-launch-template --launch-template-id $LTNAME

aws ec2 terminate-instances --instance-ids $IDS

echo "========================================================================"

echo "Waiting for Instance to get terminated......."

echo "========================================================================"

aws ec2 wait instance-terminated --instance-ids $IDS

echo "========================================================================"

echo " Instance Terminated......."

echo "========================================================================"

aws autoscaling delete-auto-scaling-group --auto-scaling-group-name $SCALINGNAME

echo "========================================================================"

echo "Auto Scaling Group Deleted......."

echo "========================================================================"

aws elbv2 delete-load-balancer --load-balancer-arn $LOADBALANCERARN

aws elbv2 delete-target-group --target-group-arn $TARGETGROUP