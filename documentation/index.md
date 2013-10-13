---
layout: documentation
title: Getting started with PHP-VCR
categories:
 - documentation
---

PHP-VCR record your test suite's HTTP interactions and replays them during future test runs for fast, deterministic, accurate tests.
 
 * [Welcome to PHP-VCR]
 * [Installation]
 * [Configuration]
 * [FAQ]
 * [Read the API docs]

## Examples

There are some examples how to use PHP-VCR in a project:

 * SOAP Weather API test
 * Curl Github API test

## Library hooks

Library hooks can be enabled or disabled. If enabled, all HTTP interactions issued by a library like curl or soap are intercepted.
If disabled, no HTTP interactions of the issuing library are recorded.

More information on each library hook:

 * [Curl]
 * [Soap]
 * [StreamWrapper]

## Request matching

In order to replay previously recorded requests, PHP-VCR must match new HTTP requests to a previously recorded one. By default, it matches on HTTP method and URI, since that is usually deterministic and fully identifies the resource and action for typical RESTful APIs.

PHP-VCR intercepts HTTP requests when they happen and ...
You can customize how PHP-VCR matches requests using the enableRequestMatcher() configuration option.

    \\VCR\\VCR::configue()
        ->enableRequestMatcher;


Specify an array of attributes to match on. Supported attributes are:
