#!/bin/bash
set -e

ENVIRONMENT_NAME=$1
VPC_ID=$2
SUBNET_ID=$3

case "$ENVIRONMENT_NAME" in
  "dev")
      EC2_KEY_NAME="amazon-linux-key"
      EC2_INSTTANCE_TYPE="t2.micro"
      ;;
  "qa")
    EC2_KEY_NAME="amazon-linux-key"
    EC2_INSTTANCE_TYPE="t2.micro"
      ;;
  "prod")
    EC2_KEY_NAME="amazon-linux-key"
    EC2_INSTTANCE_TYPE="t2.small"
    ;;
esac

EC2_CF_STACK_NAME="${ENVIRONMENTT_NAME}-ec2-stack"
EC2_CF_TEMPLATE_FILE="cf_templates/cf_ec2_iam.yml"
ls -alR

echo "ENVIRONMENTT_NAME is $ENVIRONMENTT_NAME "
echo " VPC_ID is $VPC_ID "
echo " SUBNET_ID is $SUBNET_ID "
echo " EC2_KEY_NAME is $EC2_KEY_NAME "
echo " EC2_INSTANCE_TYPE is $EC2_INSTANCE_TYPE "
echo " EC2_CF_STACK_NAME is $EC2_CF_STACK_NAME "
echo " EC2_CF_TEMPLATE_FILE is $EC2_CF_TEMPLATE_FILE"

echo " Start CF Deployment of EC2 Resources on $(date +'%Y-%M-%d %T %Z') with Stack Name as ${EC2_CF_STACK_NAME}"

aws cloudformation deploy \
    --region ${AWS_REGION} \
    --stack-name ${EC2_CF_STACK_NAME} \
    --template-file ${EC2_CE_TEMPLATE_FILE} \
    --parameter-overrides \
        KeyName=${EC2_KEYY_NAME} \
        InstanceType=${EC2_INSTANCE_TYPE} \
        EnvironmentName=${ENVIRONMENT_NAME} \
        VpcId=${VPC_ID} \
        SubnetId=${SUBNET_ID} \
    --no-fail-on-empty-changeset \
    --capabilities CAPABILITY_NAMED_IAM    

echo " Completed - CF Deployment of EC2 Resources on $(date + '%Y-%M-%d %T %Z' with Stack Nam as ${EC2_CF_STACK_NAME})
