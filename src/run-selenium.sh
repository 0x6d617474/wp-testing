#!/usr/bin/env bash

FILEPATH='selenium.jar'
PIDFILE='.selenium'

java -jar ${FILEPATH} > /dev/null 2>&1 &
PID=$!
echo ${PID} > ${PIDFILE}
