#!/usr/bin/env bash

PREFIX="[BENCHMARK]"
ERROR="[ERROR]"
BUILDPACK_URL=$1
APP_NAME="benchmark$(date | md5 | fold -w20 | head -n1)"
LOG_FILE="./output.log"

echo "$PREFIX Creating test application $APP_NAME"
cctrlapp $APP_NAME create custom --buildpack=$BUILDPACK_URL 1>&2 2>$LOG_FILE

if [ $? -ne 0 ]; then
    echo "$ERROR App creation failed. Check $LOG_FILE";
    exit 1;
fi

echo "$PREFIX Pushing test application $APP_NAME"
cctrlapp $APP_NAME/default push 1>&2 2>$LOG_FILE

if [ $? -ne 0 ]; then
    echo "$ERROR Push failed. Check $LOG_FILE";
    cctrlapp $APP_NAME delete -f
    exit 1;
else
    cctrlapp $APP_NAME/default undeploy -f
    cctrlapp $APP_NAME delete -f
    echo "$PREFIX Build time: $(grep 'Total time' $LOG_FILE | awk '{print $6}')"
fi

