WITH airlines AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__airlines') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY airline_name, iata_code, icao_code) AS airline_id,
    airline_name,
    icao_code,
    iata_code,
    iata_prefix_accounting,

    country_iso2,
    country_name,
    callsign,

    fleet_size,
    fleet_average_age,

    date_founded,

    status,
    type
FROM 
    airlines 
    