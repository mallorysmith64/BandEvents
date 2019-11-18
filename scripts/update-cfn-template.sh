#!/bin/bash
WAIT=./scripts/wait-for-cf.sh

ACTIONS="$*"

if [ $# -eq 0 ]
then
        ACTIONS=USAGE
fi
for ACTION in $ACTIONS
do
        echo ACTION=$ACTION
        case $ACTION in
        00)
                echo updating 00: be-globals
                aws cloudformation deploy --region $AWS_REGION \
                        --capabilities CAPABILITY_IAM \
                        --stack-name be-globals \
                        --template-file 00-globals.yaml
                ;;
        02)
                echo updating 00: be-dynamodb
                aws cloudformation deploy --region $AWS_REGION \
                        --stack-name be-dynamodb \
                        --template-file 02-dynamodb.yaml
                ;;
        00-destroy)
                echo deleting 00: be-globals
                aws cloudformation delete-stack --region $AWS_REGION --stack-name be-globals
                ;;
        02-destroy)
                echo deleting 02: be-dynamodb
                aws cloudformation delete-stack --region $AWS_REGION --stack-name be-dynamodb
                ;;
        create)
                $0 00 02
                ;;
        destroy)
                $0 02-destroy 00-destroy 
                ;;
        *)
                echo Usage: `basename $0` "create|destroy|00|02|00-destroy|02-destroy"
                exit 1
                ;;
        esac
done
$WAIT