#!/bin/bash

# Variables
INSTANCE_NAME="ng-main-noa-itay-Prod"
LOAD_BALANCER_NAME="alb-ingress-noa-itay-Prod"

# Step 1: Get the Instance ID with status running
INSTANCE_ID=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_NAME" \
              "Name=instance-state-name,Values=running" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text)

if [ "$INSTANCE_ID" == "None" ]; then
    echo "Running instance with name $INSTANCE_NAME not found."
    exit 1
fi

echo "Instance ID: $INSTANCE_ID"

# Step 2: Get the Security Group ID of the Instance
INSTANCE_SG_ID=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --query "Reservations[0].Instances[0].SecurityGroups[0].GroupId" \
    --output text)

if [ "$INSTANCE_SG_ID" == "None" ]; then
    echo "No security group found for instance $INSTANCE_ID."
    exit 1
fi

echo "Instance Security Group ID: $INSTANCE_SG_ID"

# Step 3: Get the Security Group ID(s) of the Load Balancer
LB_SG_IDS=$(aws elbv2 describe-load-balancers \
    --names "$LOAD_BALANCER_NAME" \
    --query "LoadBalancers[0].SecurityGroups" \
    --output text)

if [ -z "$LB_SG_IDS" ]; then
    echo "No security groups found for load balancer $LOAD_BALANCER_NAME."
    exit 1
fi

echo "Load Balancer Security Group ID(s): $LB_SG_IDS"

# Step 4: Add Inbound HTTP Rule to the Instance's Security Group from Load Balancer Security Group(s)
for LB_SG_ID in $LB_SG_IDS; do
    aws ec2 authorize-security-group-ingress \
        --group-id "$INSTANCE_SG_ID" \
        --protocol tcp \
        --port 443 \
        --source-group "$LB_SG_ID"
    echo "Added HTTP rule from $LB_SG_ID to $INSTANCE_SG_ID"
done

echo "Script completed successfully."
