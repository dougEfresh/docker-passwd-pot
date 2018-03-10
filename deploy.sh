#!/bin/bash

REGION=${1:?}
IMAGE=${2:?}
stackName=passwdpot
dockerRun="docker run -v $PWD:/tmp/aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -t -i pebbletech/docker-aws-cli aws"

$dockerRun --region $REGION cloudformation delete-stack   --stack-name $stackName && \
$dockerRun --region $REGION cloudformation wait stack-delete-complete  --stack-name $stackName
$dockerRun --region $REGION cloudformation create-stack --stack-name $stackName  --template-body file://tmp/aws/passwdpot.json \
    --parameters "ParameterKey=KeyName,ParameterValue=passwdpot" \
    "ParameterKey=PasswdPotDockerImage,ParameterValue=$IMAGE" \
    "ParameterKey=PasswdPotApiServer,ParameterValue=api.passwd-pot.com" \
    "ParameterKey=LogzKey,ParameterValue=$LOGZ" && \
$dockerRun --region $REGION cloudformation wait stack-create-complete   --stack-name $stackName && \
$dockerRun --region $REGION cloudformation describe-stacks --stack-name $stackName  --query 'Stacks[*].Outputs' 
