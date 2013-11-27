#!/usr/bin/env bash

$(which md5 > /dev/null)

if [ $? -eq 0 ]; then
    MD5_CMD="md5";
else
    $(which md5sum > /dev/null)
    if [ $? -eq 0 ]; then
        MD5_CMD="md5sum"
    else
        echo "$PREFIX 'md5 | md5sum' required"
        exit 1;
    fi
fi

function cleanup() {
    echo "$PREFIX Cleaning up..."
    cctrlapp $APP_NAME/default undeploy -f 1>&2 2>$LOG_FILE
    cctrlapp $APP_NAME delete -f 1>&2 2>$LOG_FILE
    echo "$PREFIX Done!"
    exit 0
}

PREFIX="[BENCHMARK]"
ERROR="[ERROR]"
BUILDPACK_URL=$1
APP_NAME="benchmark$(date | $MD5_CMD | fold -w20 | head -n1)"
LOG_FILE="./output.log"

echo "$PREFIX Creating test application $APP_NAME"
cctrlapp $APP_NAME create custom --buildpack=$BUILDPACK_URL 1>&2 2>$LOG_FILE
trap cleanup INT

if [ $? -ne 0 ]; then
    echo "$ERROR App creation failed. Check $LOG_FILE";
    exit 1;
fi

echo "$PREFIX Pushing test application $APP_NAME"
cctrlapp $APP_NAME/default push 1>&2 2>$LOG_FILE

if [ $? -ne 0 ]; then
    echo "$ERROR Push failed. Check $LOG_FILE";
else
    echo "$PREFIX Build time: $(grep 'Total time' $LOG_FILE | awk '{print $6}')"
fi

cleanup