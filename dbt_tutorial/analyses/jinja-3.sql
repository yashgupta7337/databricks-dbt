-- if its incrementally load process then load the data from bronze_sales only if last load id > 3
{% set incr_load_flag = 1 %}
{% set last_load_id = 3 %}
{% set columns = ['sales_id', 'date_sk', 'gross_amount'] %}

select
    {% for column in columns %}
        {{ column }} {% if not loop.last %} , {% endif %}
    {% endfor %}
from
    {{ ref('bronze_sales') }}

{% if incr_load_flag == 1 %}

    WHERE date_sk > {{ last_load_id }}

{% endif %}