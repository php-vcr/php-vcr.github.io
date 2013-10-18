---
layout: documentation
title: Welcome to PHP-VCR
categories:
 - documentation
---

PHP-VCR records your test suite's HTTP interactions and replays them during future test runs for fast, deterministic, accurate tests.
 
 * Welcome to PHP-VCR
 * [Installation]
 * [Configuration]
 * [Performance]

<!--  * [FAQ]
 * [Read the API docs]
 -->
## Examples

There are some examples how to use PHP-VCR in a project:

 * SOAP Weather API test
 * Curl Github API test

## Library hooks

Library hooks allow PHP-VCR to intercept HTTP requests by overwriting the libraries method to issue requests. 

More information on each library hook:

 * [libraryhooks#Curl]
 * [libraryhooks#Soap]
 * [libraryhooks#StreamWrapper]

