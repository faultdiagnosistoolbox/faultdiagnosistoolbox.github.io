---
layout: single_notitle
author_profile: true
permalink: /tutorials/
title: Tutorials -- Fault Diagnosis Toolbox
---
# Tutorials
<!--h3 class="archive__subtitle">Available tutorial topics test</h3-->
<div class="grid__wrapper">
{% assign items = site.posts | sort: 'level' %}
{% for post in items %}
{% if post.category == "tutorial" and post.level < 10 %}
  {% include archive-single.html type="grid" %}      
{% endif %}
{% endfor %}
</div>

<p>
<div class="grid__wrapper">
{% for post in items %}
{% if post.category == "tutorial" and post.level>=10 and post.level < 20 %}
  {% include archive-single.html type="grid" %}      
{% endif %}
{% endfor %}
</div>
{% include paginator.html %}
