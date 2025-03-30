WITH airports AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__airports') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY airport_name, iata_code, icao_code) AS airport_id,
    airport_name,
    iata_code,
    icao_code,
    
    latitude,
    longitude,
    timezone,

    country_iso2,
    country_name,
    city_iata_code
FROM 
    airports 
    