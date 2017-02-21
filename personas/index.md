---

layout: default

---


{% for persona in site.data.personas %}
<section>
  <h2>
      {{ persona.title }}
  </h2>
  <p>{{ persona.person }}</p>
  <p><strong>Need</strong> {{ persona.need }}</p>
  {% if persona.annotation %}
  <p><strong>Annotation</strong> {{ persona.annotation }}</p>
  {% endif %}
  {% if persona.structure %}
  <p><strong>Structure</strong> {{ persona.structure }}</p>
   {% endif %}
  {% persona.categorize-tag %}
  <p><strong>Categorize and tag</strong>  {{ persona.categorize-tag }}</p>
   {% endif %}
  {% persona.sort-organize %}
  <p><strong>Sort and Organize</strong> {{ persona.sort-organize }}</p>
   {% endif %}
   {% persona.export %}
  <p><strong>Export</strong> {{ persona.export }}</p>
   {% endif %}
   {% if persona.import %}
  <p><strong>Import</strong> {{ persona.import }}</p>
   {% endif %}
   {% if persona.collaboration %}
  <p><strong>Collaboration</strong> {{ persona.collaboration }}</p>
   {% endif %}
   {% if persona.notes %}
  <p><strong>Notes</strong> {{ persona.notes }}</p>
   {% endif %}
</section>

{% endfor %}
