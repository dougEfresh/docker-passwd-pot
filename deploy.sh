#!/bin/bash

REGION=${1:?}
IMAGE=${2:?}
stackName=passwdpot
dockerRun="docker run -v $PWD:/tmp/aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -t -i mesosphere/aws-cli"

$dockerRun --region $REGION cloudformation delete-stack   --stack-name $stackName && \
$dockerRun --region $REGION cloudformation wait stack-delete-complete  --stack-name $stackName
$dockerRun --region $REGION cloudformation create-stack --stack-name $stackName  --template-body file:///tmp/aws/passwdpot.yaml \
    --parameters "ParameterKey=KeyName,ParameterValue=passwdpot" \
    "ParameterKey=PasswdPotDockerImage,ParameterValue=$IMAGE" \
    "ParameterKey=PasswdPotApiServer,ParameterValue=euk1y5r2ji.execute-api.us-east-2.amazonaws.com" \
    "ParameterKey=LogzKey,ParameterValue=$LOGZ" && \
$dockerRun --region $REGION cloudformation wait stack-create-complete   --stack-name $stackName && \
$dockerRun --region $REGION cloudformation describe-stacks --stack-name $stackName  --query 'Stacks[*].Outputs' 
