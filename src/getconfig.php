#!/usr/bin/env php
<?php

$dir = __DIR__;
$found = false;
do {
    $dir = realpath(sprintf('%s/..', $dir));
    if (empty($dir) || $dir === '/') {
        die("UNABLE TO LOCATE WORDPRESS");
    }
    $found = file_exists(sprintf('%s/wp-config.php', $dir));
} while (!$found);

require_once sprintf('%s/wp-load.php', $dir);
echo get_option('siteurl') . "\n";
echo WPMU_PLUGIN_DIR;
