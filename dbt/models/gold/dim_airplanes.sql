WITH airplanes AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__airplanes') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY registration_number) AS airplanes_id,
    registration_number,
    model_name,
    model_code,
    plane_owner,
    construction_number,
    production_line,
    iata_type,
    first_flight_date,
    delivery_date,
    plane_series,
    engines_count,
    engines_type,
    plane_age,
    plane_status
FROM 
    airplanes 
    