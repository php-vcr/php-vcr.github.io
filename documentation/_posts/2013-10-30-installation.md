---
layout: documentation
title: Installation
---

PHP-VCR is available via [composer](http://getcomposer.org) which is the recommended way to install PHP-VCR. Composer is a dependency management tool for PHP that allows you to declare the dependencies your project needs and installs them into your project.

    # Install Composer
    curl -sS https://getcomposer.org/installer | php

    # Add PHP-VCR as a dependency
    php composer.phar require php-vcr/php-vcr:~1.0

After installing you need to turn on PHP-VCR in your test bootstrap file (for example in `tests/boostrap.php`). 

**Important:** Make sure you enable PHP-VCR right after Composer's autoloader.

    require 'vendor/autoload.php';
    \VCR\VCR::turnOn();

You can find out more on how to install Composer, configure autoloading, and other best-practices for defining dependencies at [getcomposer.org](http://getcomposer.org).

### Requirements

For PHP-VCR to work you need a PHP version greater than PHP 5.3 and the [curl PHP extension](http://php.net/manual/en/book.curl.php).   

### Latest version

To keep up with the latest changes on the master branch, you can set the version requirement for PHP-VCR to `dev-master`.

    {
       "require": {
          "php-vcr/php-vcr": "dev-master"
       }
    }

Don't forget to run `composer update` after changing your composer.json.


### Contributing to PHP-VCR

In order to contribute, you'll need to checkout the source from GitHub and install PHP-VCR's dependencies using Composer:

    # Download PHP-VCR sources
    git clone https://github.com/php-vcr/php-vcr.git 
    cd php-vcr 

    # Install dependencies    
    composer install --dev

    # Run tests
    phpunit

PHP-VCR is unit tested with [PHPUnit](http://phpunit.de). You will need to [install PHPUnit](http://phpunit.de/manual/3.8/en/installation.html) if you haven't already. Run the tests using the PHPUnit binary.

### Framework integrations

#### Using PHP-VCR with PHPUnit

Install [PHP-VCR PHPUnit-Testlistener](https://github.com/php-vcr/phpunit-testlistener-vcr) in order to integrate PHP-VCR with PHPUnit. You can use the `@vcr` annotation to turn on PHP-VCR for a single test.

    /**
     * @vcr [cassette_path]
     */
    public function testInterceptsWithAnnotations()
    {
        $result = file_get_contents('http://example.com');

        $this->assertEquals('This is a annotation test dummy.', $result, 'Call was not intercepted (using annotations).');
    }

Replace `[cassette_path]` with the path to your cassette file relative to the cassette path. Requests are intercepted and stored into the cassette file provided via the `@vcr` annotation. PHP-VCR is automatically turned on and off.