#!/bin/bash

if [ -z $1 ]
then
    LOGFILE="auth.log"
else
    LOGFILE=$1
fi

if [ ! -f $LOGFILE ]
then
    echo "Log file not found"
    exit 1
fi

tail -n 1000 $LOGFILE \
    | grep -E "Accepted" \
    | awk '/from/{for(i=1;i<=NF;i++)if($i=="from")print $(i+1)}' \
    | sort \
    | uniq \
    | wc -l
