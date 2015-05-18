---
layout: page
permalink: archive/
search_omit: true
title: Archive
---

{% for post in site.posts %}
{% unless post.next %}
{{ post.date | date: '%Y' }}
{{ post.date | date: '%B' }}
{% else %}
{% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
{% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
{% if year != nyear %}
{{ post.date | date: '%Y' }}
{% endif %}
{% capture month %}{{ post.date | date: '%B' }}{% endcapture %}
{% capture nmonth %}{{ post.next.date | date: '%B' }}{% endcapture %}
{% if month != nmonth %}
{{ post.date | date: '%B' }}
{% endif %}
{% endunless %}
{{ post.date | date: "%d" }}
<a href="{{ post.url }}">{{ post.title | downcase }}</a>
{% endfor %}
