#!/usr/bin/env bash

PIDFILE='.phantomjs'

kill -9 $(cat ${PIDFILE})
rm -f ${PIDFILE}
killall phantomjs # just to be sure
