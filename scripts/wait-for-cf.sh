#!/bin/bash
START=`date +%s`
while : 
do
    count=`aws cloudformation --region $AWS_REGION list-stacks | grep '"StackStatus"' | egrep -v 'COMPLETE"' | wc -l`
    if [ $count = 0 ]
    then
        END=`date +%s`
        ELAPSED=$(( $END - $START ))
        echo updates complete after $ELAPSED seconds
        if [ $ELAPSED -gt 5 ]
        then
            if [ -x /usr/bin/say ]
            then
                say updates complete after $ELAPSED seconds
            fi
        fi
        exit 0
    fi
    sleep 3
done