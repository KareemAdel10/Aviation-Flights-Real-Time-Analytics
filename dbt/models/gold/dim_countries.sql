WITH countries AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__countries') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY country_name) AS country_id,
    country_name,
    country_iso2,
    capital,
    continent,
    currency_name,
    population,
    phone_prefix
FROM 
    countries 
    