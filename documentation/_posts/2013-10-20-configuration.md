---
layout: documentation
title: Configuration
---

PHP-VCR can be configured by calling it's `configure` method which returns a `Configuration` object which is a [fluent interface](http://en.wikipedia.org/wiki/Fluent_interface) that can be used to change the behavior of PHP-VCR.

    \VCR\VCR::configure();

### Library hooks

**By default all [library hooks] are enabled**. You can specifically enable only some hooks by configuring PHP-VCR. In your bootstrap file you can do:

    require_once __DIR__ . '/../vendor/autoload.php';

    \VCR\VCR::configure()->enableLibraryHooks(array('curl_rewrite', 'soap'));
    \VCR\VCR::turnOn();

Library hooks can only intercept HTTP requests if PHP-VCR is turned on right after initializing your autoloader, before the actual class to be replaced is loaded.
Once loaded php-vcr does not have any change to do its' magic and intercept any request and/or response invoked by this class.


### Request matching

In order to replay previously recorded requests, PHP-VCR must match new HTTP requests to a recorded one. By default, it matches all aspects of a HTTP request to fully identify the resource and action. Available request matchers are:

 * `method` matches the HTTP method like GET, POST, ...
 * `url` matches the URI
 * `host` matches the host name
 * `headers` matches all headers
 * `body` matches the request body
 * `post_fields` matches any post fields

You can customize how PHP-VCR matches requests using the configuration option. List every name of a matcher that should be enabled.

    \VCR\VCR::configure()
        ->enableRequestMatchers(array('method', 'url', 'host'));

PHP-VCR allows you to define your own request matchers as callback functions and combine them with existing ones.

    \VCR\VCR::configure()
        ->addRequestMatcher(
            'custom_matcher',
            function (\VCR\Request $first, \VCR\Request $second) {
                // custom request matching
                return true;
            }
        )
        ->enableRequestMatchers(array('method', 'url', 'custom_matcher'));

### White- and Blacklisting paths

PHP-VCR scans and overwrites your PHP code on-the-fly in order to hook into libraries like cUrl and SOAP. By default all paths except the PHP-VCR library hooks folder are scanned.

To speedup the test execution, you might want to exclude (blacklist) or specifically include (whitelist) one or more paths to be scanned throughout the test execution:

    \VCR\VCR::configure()
        ->setBlackList(array('do/not/scan/this/path'))
        ->setWhiteList(array('vendor/guzzle'));

Paths you provide are substrings. For example if `vendor\guzzle` is on the whitelist, only files containing that path are scanned – think of `*vendor\guzzle*`.
You certainly can use white- and blacklisting in one setup, but be aware that a PHP-VCR scans and overwrites paths only if they are in a whitelist and not on a blacklist.
