---
layout: archive
author_profile: true
permalink: /tutorials/
---

{% include base_path %}

<!-- <h3 class="archive__subtitle">Available tutorial topics test</h3> destroys grid view-->

{% assign items = site.posts | sort: 'level' %}
{% for post in items %}
{% if post.category == "tutorial" %}
  {% include archive-single.html type="grid" %}      
{% endif %}
{% endfor %}

{% include paginator.html %}
