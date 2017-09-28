<?php

namespace Your\Name\Space\Here;

final class SampleTest extends TestCase
{
    public function test_sample()
    {
        $key = '_DEBUG';
        $value = 'DEBUG';
        update_option($key, $value);

        $this->assertEquals($value, get_option($key));
    }
}
