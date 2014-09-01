---
layout: page
permalink: archive/
search_omit: true
title: Archive
---

<div class="entry">
  <script type="text/javascript">
    var domainroot="robbycolvin.com"

    function Gsitesearch(curobj){
      curobj.q.value="site:"+domainroot+" "+curobj.qfront.value
    }
  </script>

  <form action="http://www.google.com/search" method="get" onsubmit="Gsitesearch(this)">
    <p>search:<br>
    <input name="q" type="hidden" class="texta">
    <input name="qfront" type="text" class="texta" style="width: 180px; text-size: 12px; height: 12px;">&nbsp;</p>
  </form>

  <table>
    <tr>
      <th>
        <h1>
          <b>all posts</b>
        </h1>
      </th>
    </tr>

  {% for post in site.posts %}
    {% unless post.next %}
      <tr class="year">
        <th>
          <br />
          <br />
          {{ post.date | date: '%Y' }}
        </th>
      </tr>
      <tr class="archive">
        <th>
          {{ post.date | date: '%B' }}
        </th>
        <td></td>
      </tr>
    {% else %}
      {% capture year %}{{ post.date | date: '%Y' }}{% endcapture %}
      {% capture nyear %}{{ post.next.date | date: '%Y' }}{% endcapture %}
      {% if year != nyear %}
        <tr class="year">
          <th>
            <br />
            <br />
            {{ post.date | date: '%Y' }}
          </th>
        </tr>
      {% endif %}
      {% capture month %}{{ post.date | date: '%B' }}{% endcapture %}
      {% capture nmonth %}{{ post.next.date | date: '%B' }}{% endcapture %}
      {% if month != nmonth %}
        <tr class="archive">
          <th>
            {{ post.date | date: '%B' }}
          </th>
          <td></td>
        </tr>
      {% endif %}
    {% endunless %}

    <tr class="archive">
      <th>{{ post.date | date: "%d" }}</th>
      <td>
        <a href="{{ post.url }}">{{ post.title | downcase }}</a>
      </td>
    </tr>
  {% endfor %}
  </table>
</div>
