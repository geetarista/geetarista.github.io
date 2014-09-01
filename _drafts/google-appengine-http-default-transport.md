---
layout: post
title: Google Appengine http.DefaultTransport
date: 2014-08-27 00:00:00
---

When using Go on Google Appengine, the use of `http.DefaultTransport` and `http.DefaultClient` is forbidden:

> http.DefaultTransport and http.DefaultClient are not available in App Engine. See https://developers.google.com/appengine/docs/go/urlfetch/overview

Google suggests using the `"appengine/urlfetch"` package, however this is not useful if you are using a third-party package that you cannot control. You can, however, just use the transport available in that package and pass it in:

<!--more-->

{% highlight go %}
client := &http.Client{
    Transport: &urlfetch.Transport{Context: ctx},
}
{% endhighlight %}

If you're using an external package, you can do the same thing as long as you can pass the transport in. I recently used this with [tweetlib](http://gopkg.in/tweetlib.v2):

{% highlight go %}
transport := &tweetlib.Transport{
    Config:    tweetlibConfig,
    Token:     token,
    Transport: &urlfetch.Transport{Context: ctx},
}
{% endhighlight %}

If not, you'll want to fork the project and hopefully your change can make it into master.
