WITH departures AS (
    SELECT 
        departure_icao AS departure_airport_icao,
        COUNT(flight_id) AS total_departures,
        AVG(departure_delay) AS avg_departure_delay
    FROM {{ ref('fact_flights') }}
    GROUP BY departure_icao
),

arrivals AS (
    SELECT 
        arrival_icao AS arrival_airport_icao,
        COUNT(flight_id) AS total_arrivals,
        AVG(arrival_delay) AS avg_arrival_delay
    FROM {{ ref('fact_flights') }}
    GROUP BY arrival_icao
),
airport_details AS (
    SELECT 
        airport_id,
        icao_code,
        airport_name,
        city_iata_code,
        country_name
    FROM {{ ref('dim_airports') }}
)

SELECT 
    ad.airport_id,
    ad.icao_code,
    ad.airport_name,
    ad.city_iata_code,
    ad.country_name,
    COALESCE(dep.total_departures, 0) AS total_departures,
    COALESCE(dep.avg_departure_delay, 0) AS avg_departure_delay,
    COALESCE(arr.total_arrivals, 0) AS total_arrivals,
    COALESCE(arr.avg_arrival_delay, 0) AS avg_arrival_delay
FROM airport_details ad
 JOIN departures dep ON ad.icao_code = dep.departure_airport_icao
 JOIN arrivals arr ON ad.icao_code = arr.arrival_airport_icao
