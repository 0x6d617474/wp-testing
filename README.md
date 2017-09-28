# WordPress Testing Library

This is a simple testing library to add unit and integration tests to your 
WordPress packages via PHPUnit and Behat.  

## Installation  
``` 
$ composer require 0x6d617474/wp-testing --dev
```

## Requirements  

The following is required in order to use the test library: 
* PHP v5.6+
* PhantomJS or Java Runtime (for integration tests)
* SVN
* WordPress environment

## Writing Tests

Make a `tests` directory in the root of your project, with the following structure: 
```
/tests
 |---- /behat
        |---- /contexts
               |---- FeatureContext.php
        |---- /features
               |---- /core
                      |---- example.feature
 |---- /unit
        |---- bootstrap.php
        |---- ExampleTest.php
        |---- TestCase.php
```

You can find examples in the `tests` directory in this project.  

You'll also need a `behat.yml` file and `phpunit.xml` file in your project root.     

You can find examples in the root of this project. Note that only the `autoload` 
and `suites` keys are defined in the `behat.yml` file. The rest of the values 
are defined by the library and passed at runtime.    

Write your unit tests in the `tests/unit` directory, and your integration tests 
in the `tests/behat/features/core` directory. You can make additional integration 
test suites by making new folders under `tests/behat/features` and updating your 
`behat.yml` file. A `dev` suite is included in the example `behat.yml` file.

## Running Tests  

To run your unit tests, simply run `phpunit` if you have it installed locally, 
or you can run the included `vendor/bin/phpunit`.  

To run your integration tests, run the 
`vendor/bin/wp-behat [suite=core] [browser=phantomjs]` command.

## Notes  

In general, DO NOT run this test suite on a production environment. It does weird 
things with the database, and while it tries to clean up after itself, things 
happen. Just don't risk it.  

### Unit Tests  

Unit tests are run using the official WordPress test suite libraries, which are 
sourced from `develop.svn.wordpress.org`. The same database your 
WordPress installation uses is used to run the tests, however with temporary 
tables prefixed with `wptests_`. These tables are cleaned up after the test suite 
finishes. Don't prefix your real tables with `wptests_` or they will be deleted 
as well.  

### Integration Tests  

By default, the library will run the `core` test suite via `PhantomJS`. You can 
pass in arguments to change this behavior (see above). For example, to run the 
`dev` test suite via Chrome, you would call `vendor/bin/wp-behat dev chrome`.  

Just before running the tests, a `Must Use` plugin will be created in your 
WordPress installation, and the plugin will be removed afterwards. This plugin 
sets the `_WP_TESTING_ENVIRONMENT` constant, which you can use in your code 
to add/remove behavior during the run of the test suite. 
