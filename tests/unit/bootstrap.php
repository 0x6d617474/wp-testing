<?php

namespace Ox6d617474\WPTest;

$init_file = sprintf('%s/../../%s', __DIR__, $GLOBALS['WPTEST_INIT_PATH']);

require_once sprintf('%s/../../vendor/autoload.php', __DIR__);

Bootstrap::init($init_file);
