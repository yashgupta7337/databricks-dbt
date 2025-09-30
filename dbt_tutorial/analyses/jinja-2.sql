-- use list, if else and for loop
{%- set apples = ['Gala', 'Red Delicious', 'Fuji', 'McIntosh', 'Honeycrisp'] -%}
{% for apple in apples %}
    {% if apple != 'McIntosh' %}
        {{ apple }}
    {% else %}
        I hate {{ apple }} Apple
    {% endif %}
{% endfor %}

