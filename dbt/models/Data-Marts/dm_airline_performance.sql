WITH flight_summary AS (
    SELECT 
        airline_icao,
        COUNT(flight_id) AS total_flights,
        SUM(CASE WHEN flight_status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_flights,
        SUM(CASE WHEN departure_delay > 0 THEN 1 ELSE 0 END) AS delayed_flights,
        AVG(departure_delay) AS avg_departure_delay,
        AVG(arrival_delay) AS avg_arrival_delay
    FROM {{ ref('fact_flights') }}
    GROUP BY airline_icao
),

airline_details AS (
    SELECT 
        airline_id,
        icao_code,
        airline_name,
        fleet_size,
        fleet_average_age,
        country_name
    FROM {{ ref('dim_airlines') }}
)

SELECT 
    fs.airline_icao,
    ad.airline_name,
    ad.fleet_size,
    ad.fleet_average_age,
    ad.country_name,
    fs.total_flights,
    fs.cancelled_flights,
    fs.delayed_flights,
    fs.avg_departure_delay,
    fs.avg_arrival_delay
    
FROM flight_summary fs
JOIN airline_details ad ON fs.airline_icao = ad.icao_code
