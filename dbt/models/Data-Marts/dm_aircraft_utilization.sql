WITH flights AS (
    SELECT * FROM {{ ref('fact_flights') }}
),
airplanes AS (
    SELECT * FROM {{ ref('dim_airplanes') }}
)

SELECT 
    COALESCE(f.aircraft_registration, 'Unknown') AS aircraft_registration,
    COALESCE(a.iata_type, 'Unknown') AS aircraft_iata,
    COUNT(f.flight_id) AS total_flights,
    SUM(CASE WHEN f.flight_status = 'landed' THEN 1 ELSE 0 END) AS successful_flights,
    SUM(CASE WHEN f.flight_status IN ('cancelled', 'diverted') THEN 1 ELSE 0 END) AS disrupted_flights

FROM flights f
JOIN airplanes a ON a.registration_number = f.aircraft_registration
GROUP BY f.aircraft_registration, a.iata_type;