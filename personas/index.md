layout: default

---



<ul>
{% for persona in site.data.personas %}
  <li>
      {{ persona.title }}
  </li>
{% endfor %}
</ul>