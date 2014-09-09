---
layout: post
title: JavaScript automation in OS X Yosemite
date: 2014-09-09 00:00:00
---

In Mac OS X Yosemite, the automation tools incorporate a new scripting language: JavaScript. Since I have some AppleScript that I use with [Alfred](http://www.alfredapp.com/) for resizing windows, I decided to give it a try.

<!--more-->

Here is the original:

{% highlight applescript %}
tell application "Finder"
    set b to bounds of window of desktop
    set width to item 3 of b
    set height to item 4 of b
end tell
 
set name to name of ¬
  (info for (path to frontmost application))

set q to "{query}" --- the query variable from Alfred
 
tell application name
    activate
    if q is "f" then
        set nb to
          {0, 0, width, height}
    else if q is "m" then
        set nb to
          {width/8, height/8, width/1.125, height/1.125}
    else if q is "tr" then
        set nb to {width/2, 0, width, height/2}
    else if q is "tl" then
        set nb to {0, 0, width/2, height/2}
    else if q is "th" then
        set nb to {0, 0, width, height/2}
    else if q is "r" then
        set nb to {width/2, 0, width, height}
    else if q is "l" then
        set nb to {0, 0, width/2, height}
    else if q is "br" then
        set nb to {width/2, height/2, width, height}
    else if q is "bl" then
        set nb to {0, height/2, width/2, height}
    else if q is "bh" then
        set nb to {0, height/2, width, height}
    else if q is "h" then
        set nb to {width/4, 0, width/1.25, height}
    end if
end tell

set bounds of first window to nb
{% endhighlight %}

And here is the same script rewritten in JavaScript:

{% highlight javascript %}
finder = Application("Finder")
bounds = finder.desktop.window.bounds()
width = bounds["width"]
height = bounds["height"]
query = "{query}" // the query variable from Alfred

boundsMap = {
  "f":  {"x":0, "y":0, "width":width, "height":height},
  "m":  {"x":width/8, "y":height/8, 
         "width":width/1.3, "height":height/1.3},
  "tr": {"x":width/2, "y":0, "width":width, "height":height/2},
  "tl": {"x":0, "y":0, "width":width/2, "height":height/2},
  "th": {"x":0, "y":0, "width":width, "height":height/2},
  "r":  {"x":width/2, "y":0, "width":width/2, "height":height},
  "l":  {"x":0, "y":0, "width":width/2, "height":height},
  "br": {"x":width/2, "y":height/2, "width":width, "height":height},
  "bl": {"x":0, "y":height/2, "width":width/2, "height":height},
  "bh": {"x":0, "y":height/2, "width":width, "height":height/2},
  "h":  {"x":width/4, "y":0, "width":width/2, "height":height},
}

SystemEvents = Application("System Events")
appName = SystemEvents.processes.whose({ frontmost: true })[0].name()
app = Application(appName)
app.windows[0].bounds = boundsMap[query]
{% endhighlight %}

There are a couple things to note here. First, the JavaScript used is not standard. Some syntax is not required (`var`, `;`), while other syntax and globals are built in to the language: `.whose({ frontmost: true }`, `console.log`, `$`, etc. The API for interacting with objects is also different from traditional JavaScript. For example, properties are accessed like methods, e.g. `.name()`, while setters still use the `=` assignment. Element arrays are an exception—they can be accessed like regular javascript properties (`Mail.windows`), but they also have syntactic sugar as well: `Mail.windows.byName('New Message')` or `Mail.windows.byId(412)`. There is also a a global object called `ObjectSpecifier` which is used to identify an object or property's class: `ObjectSpecifier.classOf(Mail.inbox)`.

The second thing to note is the script performs the exact same function, but the JavaScript is easier to read and understand, in my opinion. I believe there are two reasons for this: the syntax is clear and the use of a data structure is intuitive. With AppleScript, it took me some time to peruse the documentation to even understand how to create a hash/map as a comparison.

I'm interested in seeing whether this becomes the preferred option for automation in Mac OS or if it is just an alternative. For now you can learn more about JavaScript automation in Yosemite at the [current (and so far, only) documentation](https://developer.apple.com/library/prerelease/mac/releasenotes/interapplicationcommunication/rn-javascriptforautomation/index.html).
