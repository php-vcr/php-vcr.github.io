---
layout: documentation
title: Welcome to PHP-VCR
categories:
 - documentation
---

PHP-VCR records your test suite's HTTP interactions and replays them during future test runs for fast, deterministic, accurate tests.
 
## Examples

There are some examples how to use PHP-VCR in a project:

 * [SOAP Weather API test](https://github.com/php-vcr/php-vcr/tree/master/tests/integration/soap)
 * [Curl Github API test](https://github.com/php-vcr/php-vcr/tree/master/tests/integration/guzzle)

## Library hooks

Library hooks allow PHP-VCR to intercept HTTP requests by overwriting the libraries method to issue requests. 

[More information on each library hook](/documentation/libraryhooks)

