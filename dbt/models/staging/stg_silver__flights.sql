-- code generation failed!
with flights as 
(
  select *
  from {{ source('silver', 'flights') }}
)
SELECT 
    -- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
    {% if var('is_test_run', default=true) %}
        
        top 100

    {% endif %}

    *
FROM flights