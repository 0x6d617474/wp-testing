#!/usr/bin/env bash

PIDFILE='.phantomjs'

phantomjs --webdriver=4444 --ignore-ssl-errors=true > /dev/null 2>&1 &
PID=$!
echo ${PID} > ${PIDFILE}
