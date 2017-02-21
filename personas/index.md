---

layout: default

---


{% for persona in site.data.personas %}
<section>
  <h2>
      {{ persona.title }}
  </h2>
  <p>{{ persona.person }}</p>
  <p>**Need** {{ persona.need }}</p>
  <p>**Annotation** {{ persona.annotation }}</p>
  <p>**Structure** {{ persona.structure }}</p>
  <p>**Categorize and tag**  {{ persona.categorize-tag }}</p>
  <p>**Sort and Organize** {{ persona.sort-organize }}</p>
  <p>**Export** {{ persona.export }}</p>
  <p>**Import** {{ persona.import }}</p>
  <p>**Collaboration** {{ persona.collaboration }}</p>
  <p>**Notes** {{ persona.notes }}</p>
</section>

{% endfor %}
