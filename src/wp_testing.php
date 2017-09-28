<?php
/*
Plugin Name:    WP-Testing-Protocol
Description:    This should NOT be enabled outside the testing environment!
Version:        1.0.0
*/
if (!defined('_WP_TESTING_ENVIRONMENT')) {
    define('_WP_TESTING_ENVIRONMENT', true);
}
