#!/usr/bin/env bash

FULL_VERSION=3.4.0
MAJOR_VERSION=3.4
URL="https://selenium-release.storage.googleapis.com/${MAJOR_VERSION}/selenium-server-standalone-${FULL_VERSION}.jar"
FILEPATH='selenium.jar'

if [ ! -f ${FILEPATH} ]; then
    wget -nv -O ${FILEPATH} ${URL} > /dev/null 2>&1
fi
