---
layout: post
title: Google App Engine http.DefaultTransport
date: 2014-09-23 10:00:00
meta_description: Learn how to replace http.DefaultTransport and http.DefaultClient in Google App Engine
---

While working on a [small project](https://github.com/geetarista/ImgurPopular) recently that utilizes [Go](http://golang.org) and Google's [App Engine](https://developers.google.com/appengine/), I ran into the following error:

> http.DefaultTransport and http.DefaultClient are not available in App Engine. See https://developers.google.com/appengine/docs/go/urlfetch/overview

<!--more-->

Google suggests using the `"appengine/urlfetch"` package to make requests, but this is not ideal. You are now at the mercy of that implementation and the possibility of being behind the standard version. Additionally, you lose the ability to make requests via third-party packages.

You can work around this by assigning a transport from that package:

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

If the package you're using doesn't expose the transport, you'll need to fork the project and hopefully your patch will be accepted.

I recommend reading the documentation for [`urlfetch`](https://developers.google.com/appengine/docs/go/urlfetch/) and [`net/http`](http://golang.org/pkg/net/http/) to better understand how they work.
