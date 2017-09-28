<?php

namespace Ox6d617474\WPTest;

use Exception;

final class Bootstrap
{
    public static function init($init_file, $plugin_dir = null, $config_file = null)
    {
        // Validate init path
        $init_file = realpath(trim($init_file));
        if (empty($init_file) || !file_exists($init_file)) {
            throw new Exception('Missing plugin init file');
        }

        // Auto configure if needed
        if (empty($plugin_dir)) {
            $plugin_dir = realpath(sprintf('%s/../', dirname($init_file)));
        }
        if (empty($config_file)) {
            $config_file = realpath(sprintf('%s/../../wp-config.php', $plugin_dir));
        }


        // Validate plugin and config paths
        $plugin_dir = realpath(trim($plugin_dir));
        if (empty($plugin_dir) || !file_exists($plugin_dir)) {
            throw new Exception('Missing plugin directory');
        }
        $config_file = realpath(trim($config_file));
        if (empty($config_file) || !file_exists($config_file)) {
            throw new Exception('Missing wp-config.php path');
        }

        // Define the library path
        $libpath = sprintf('%s/../lib', __DIR__);


        // Run the setup script
        passthru(sprintf('%s/install.sh %s %s', __DIR__, $config_file, $libpath));

        $multisite = ($GLOBALS['WPTEST_MULTISITE'] == 'true');
        if ($multisite) {
            define('WP_TESTS_MULTISITE', true);
        }

        // Define some paths
        define('WP_TESTS_DIR', $libpath);
        define('WP_TEST_PLUGIN_PATH', $plugin_dir);
        define('WP_TEST_CONFIG_PATH', $config_file);

        // Load salts and support functions
        require_once sprintf('%s/salt.php', WP_TESTS_DIR);
        require_once sprintf('%s/includes/functions.php', WP_TESTS_DIR);

        // Manually load the plugin
        tests_add_filter('muplugins_loaded', function () use ($init_file) {
            require_once $init_file;
        });

        // Away we go...
        require_once sprintf('%s/includes/bootstrap.php', WP_TESTS_DIR);
    }
}
