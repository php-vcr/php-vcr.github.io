---
layout: documentation
title: Configuration
---

PHP-VCR can be configured by calling it's `configure` method which returns a `Configuration` object which is a [fluent interface](http://en.wikipedia.org/wiki/Fluent_Interface) that can be used to change the behavior of PHP-VCR.

    \VCR\VCR::configure();

## Library hooks

**By default all [library hooks] are enabled**. You can specifically enable only some hooks by configuring PHP-VCR. In your bootstrap file you can do:

    require_once __DIR__ . '/../vendor/autoload.php';

    \VCR\VCR::configure()->enableLibraryHooks(array('curl_rewrite', 'soap'));
    \VCR\VCR::turnOn();


Library hooks can only intercept HTTP requests if PHP-VCR is turned on right after initializing your autoloader, before the actual class to be replaced is loaded.
Once loaded php-vcr does not have any change to do its' magic and intercept any request and/or response invoked by this class.


## Request matching

In order to replay previously recorded requests, PHP-VCR must match new HTTP requests to a recorded one. By default, it matches all aspects of a HTTP request to fully identify the resource and action. Available request matchers are:

 * `method` matches the HTTP method like GET, POST, ...
 * `url` matches the URI
 * `host` matches the host name
 * `headers` matches all headers
 * `body` matches the request body
 * `post_fields` matches any post fields

You can customize how PHP-VCR matches requests using the configuration option. List every name of a matcher that should be enabled.

    \VCR\\VCR::configue()
        ->enableRequestMatchers(array('method', 'url', 'host'));

PHP-VCR allows you to define your own request matchers as callback functions and combine them with existing ones.

    \VCR\\VCR::configue()
        ->addRequestMatcher(
            'custom_matcher',
            function (\VCR\Request $first, \VCR\Request $second) {
                // custom request matching
                return true;
            }
        )
        ->enableRequestMatchers(array('method', 'url', 'custom_matcher'));

## White- and Blacklisting methods

In special occasions, like a dedicated test scenario, you might want to exclude (blacklisting) or especially include (whitelisting) one or more methods throughout the test execution.
This can be achieved by registering the name of the methods to either the recognized blacklist:

    \VCR\VCR::configure()->setBlackList(array('NameOfTheSpecialMethod'));

or the provided whitelist:

    VCR\VCR::configure()->setWhiteList(array('NameOfTheSpecialMethod'));

You certainly can use both in one setup, but be aware that a method set in the whitelist rules out the same method added to the blacklist and will be processed even when added to the blacklist.
Both methods (setBlacklist() and setWhiteList()) do also follow the fluent interface paradigm mentioned above.
