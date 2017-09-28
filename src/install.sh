#!/usr/bin/env bash

function wptest.install()
{
    local config_file=$1
    local test_dir=$2

    # Define some environment variables
    WP_TESTS_DIR=${test_dir}
    WP_CORE_DIR=$(dirname ${config_file})
    WP_CORE_DIR=$(echo ${WP_CORE_DIR} | sed "s:/\+$::") # remove all forward slashes in the end
    WP_CORE_VERSION=$(cat ${WP_CORE_DIR}/wp-includes/version.php <(echo 'echo $wp_version;') | grep -v "^require_once" | grep -v "^<?php" | xargs -0 php -r)
    WP_TESTS_TAG="tags/${WP_CORE_VERSION}"
    WP_TEST_CONFIG_FILE="${WP_TESTS_DIR}/wp-tests-config.php"

    # Grab the testing library if needed
    if [[ ! -d ${WP_TESTS_DIR} ]]; then
        # Read the database config from the wp-config.php file
        local DB_NAME=$(cat ${config_file} <(echo 'echo DB_NAME;') | grep -v "^require_once" | grep -v "^<?php" | xargs -0 php -r)
        local DB_USER=$(cat ${config_file} <(echo 'echo DB_USER;') | grep -v "^require_once" | grep -v "^<?php" | xargs -0 php -r)
        local DB_PASS=$(cat ${config_file} <(echo 'echo DB_PASSWORD;') | grep -v "^require_once" | grep -v "^<?php" | xargs -0 php -r)
        local DB_HOST=$(cat ${config_file} <(echo 'echo DB_HOST;') | grep -v "^require_once" | grep -v "^<?php" | xargs -0 php -r)

        # Grab the test library files
        mkdir -p ${WP_TESTS_DIR}
        svn co --quiet https://develop.svn.wordpress.org/${WP_TESTS_TAG}/tests/phpunit/includes/ ${WP_TESTS_DIR}/includes
        svn co --quiet https://develop.svn.wordpress.org/${WP_TESTS_TAG}/tests/phpunit/data/ ${WP_TESTS_DIR}/data

        # Grab the config file
        if [[ -f ${WP_TEST_CONFIG_FILE} ]]; then
            rm -f ${WP_TEST_CONFIG_FILE}
        fi
        wget -nv -O ${WP_TEST_CONFIG_FILE} https://develop.svn.wordpress.org/${WP_TESTS_TAG}/wp-tests-config-sample.php > /dev/null 2>&1

        # Grab some salts
        wget -nv -O ${WP_TESTS_DIR}/salt.php https://api.wordpress.org/secret-key/1.1/salt/ > /dev/null 2>&1
        echo -e "<?php\n$(cat ${WP_TESTS_DIR}/salt.php)" > ${WP_TESTS_DIR}/salt.php

        # Portability!
        if [[ $(uname -s) == 'Darwin' ]]; then
            ioption='-i .bak'
        else
            ioption='-i'
        fi

        # Insert database config
        sed $ioption "s:dirname( __FILE__ ) . '/src/':'$WP_CORE_DIR/':" ${WP_TEST_CONFIG_FILE}
        sed $ioption "s/youremptytestdbnamehere/$DB_NAME/" ${WP_TEST_CONFIG_FILE}
        sed $ioption "s/yourusernamehere/$DB_USER/" ${WP_TEST_CONFIG_FILE}
        sed $ioption "s/yourpasswordhere/$DB_PASS/" ${WP_TEST_CONFIG_FILE}
        sed $ioption "s|localhost|${DB_HOST}|" ${WP_TEST_CONFIG_FILE}

        # Override message
        sed $ioption "s|use -c tests/phpunit/multisite.xml|set WPTEST_MULTISITE in phpunit.xml|" ${WP_TESTS_DIR}/includes/bootstrap.php
        sed $ioption "s|echo sprintf( 'Not running|//echo sprintf( 'Not running|" ${WP_TESTS_DIR}/includes/bootstrap.php
    fi
}

set -e

wptest.install $1 $2;






