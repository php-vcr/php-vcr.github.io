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
 * `url` matches the path of the URI; does not include the query string
 * `query_string` matches the query string
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

### Storage

PHP-VCR stores HTTP interactions on disk in YAML or JSON. PHP-VCR can use also a Backhole storage, this storage loses everything. By default, PHP-VCR use the YAML storage.

Warning: Using the YAML storage could lead to a segmentation fault. The problem could be fixed by increasing pcre.backtrack_limit in php.ini or by the use of JSON storage.

    \VCR\VCR::configure()
        ->setStorage('json');


### White- and Blacklisting paths

PHP-VCR scans and overwrites your PHP code on-the-fly in order to hook into libraries like cUrl and SOAP. By default all paths except the PHP-VCR library hooks folder are scanned.

To speedup the test execution, you might want to exclude (blacklist) or specifically include (whitelist) one or more paths to be scanned throughout the test execution:

    \VCR\VCR::configure()
        ->setBlackList(array('do/not/scan/this/path'))
        ->setWhiteList(array('vendor/guzzle'));

Paths you provide are substrings. For example if `vendor\guzzle` is on the whitelist, only files containing that path are scanned – think of `*vendor\guzzle*`.
You certainly can use white- and blacklisting in one setup, but be aware that a PHP-VCR scans and overwrites paths only if they are in a whitelist and not on a blacklist.


### Record modes

The record mode determines how requests are handled. Available modes are:

 * `new_episodes` always allows new HTTP requests, mode by default.
 * `once` will allow new HTTP requests the first time the cassette is created then throw an exception after that.
 * `none` will never allow new HTTP requests.

    ```
    \VCR\VCR::configure()
        ->setMode('once');
    ```
