#!/usr/bin/env bash

PIDFILE='.selenium'

kill -9 $(cat ${PIDFILE})
rm -f ${PIDFILE}
