<?php

namespace Ox6d617474\WPTest;

use WP_UnitTestCase;

abstract class WPTestCase extends WP_UnitTestCase
{
    /**
     * {@inheritdoc}
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * {@inheritdoc}
     */
    public function setup()
    {
        parent::setup();
    }

    /**
     * {@inheritdoc}
     */
    public function teardown()
    {
        parent::teardown();
    }
}
