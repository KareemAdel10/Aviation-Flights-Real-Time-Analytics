WITH cities AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__cities') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY city_name, iata_code) AS city_id,
    city_name,
    iata_code,
    latitude,
    longitude,
    timezone,
    country_iso2
FROM 
    cities 
    