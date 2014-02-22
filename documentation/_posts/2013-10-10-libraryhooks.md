---
layout: documentation
title: Library Hooks
---

Library hooks allow PHP-VCR to **intercept HTTP requests** by overwriting the libraries method to issue requests.
Currently there are these library hooks available:

 * `curl` intercepting requests issued by ext-curl using source-code overwriting
 * `soap` intercepting requests issued by [SoapClient](http://php.net/SoapClient) using source-code overwriting
 * `stream_wrapper` intercepting requests issued by any PHP function based on stream wrappers like [fopen](http://php.net/fopen), [file_get_contents](http://php.net/file_get_contents)

Library hooks can be enabled or disabled. If enabled, all HTTP interactions issued by a library are intercepted and handled by PHP-VCR. If disabled, HTTP interactions of the issuing library are intercepted but only forwarded without recording. By default all library hooks are enabled. You can specifically enable only some hooks by configuring PHP-VCR before turning it on.

    \VCR\VCR::configure()->enableLibraryHooks(array('curl', 'soap'));
    \VCR\VCR::turnOn();

### Curl

The `curl` hook intercepts HTTP interactions made by the popular `ext-curl` PHP extension. Specifically the following functions will be overwritten.

    curl_init
    curl_exec
    curl_getinfo
    curl_setopt
    curl_setopt_array
    curl_multi_add_handle
    curl_multi_remove_handle
    curl_multi_exec
    curl_multi_info_read


### Soap

The `soap` hook intercepts SOAP requests by overwriting the `SoapClient` class. There are two possibilities where your source-code can be overwritten: Either you use your own SoapClient implementation, then PHP-VCR overwrites your `extends SoapClient` definition or if you use it directly PHP-VCR overwrites `new SoapClient`.

PHP-VCR overwrites SOAP communication right before the request is sent by overwriting `__doRequest()`. If you implemented any changes in your own SoapClient implementation they should not be influenced.

### StreamWrapper

The `stream_wrapper` hook registers a global [stream wrapper](http://php.net/stream_wrapper) for HTTP and HTTPS protocols. This way [all PHP functions using stream wrappers] will be intercepted.

