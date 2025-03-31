WITH flights AS (
    SELECT * FROM {{ ref('fact_flights') }}
),
airports AS (
    SELECT * FROM {{ ref('dim_airports') }}
),
cities AS (
    SELECT * FROM {{ ref('dim_cities') }}
),
countries AS (
    SELECT * FROM {{ ref('dim_countries') }}
)
SELECT 
    f.flight_id,
    f.flight_number,
    f.flight_date,
    f.flight_status,

    -- Departure details
    f.departure_icao,
    COALESCE(dep.airport_name, 'Unknown') AS departure_airport,
    COALESCE(dep.city_iata_code, 'Unknown') AS departure_city_iata,
    COALESCE(dep_city.city_name, 'Unknown') AS departure_city,
    COALESCE(dep.country_iso2, 'Unknown') AS departure_country_iso,
    COALESCE(dep.country_name, 'Unknown') AS departure_country,
    -- Arrival details
    f.arrival_icao,
    COALESCE(arr.airport_name, 'Unknown') AS    arrival_airport,
    COALESCE(arr.city_iata_code, 'Unknown') AS  arrival_city_iata,
    COALESCE(arr_city.city_name, 'Unknown') AS  arrival_city,
    COALESCE(arr.country_iso2, 'Unknown') AS    arrival_country_iso,
    COALESCE(arr.country_name, 'Unknown') AS    arrival_country

FROM flights f
LEFT JOIN airports dep ON f.departure_icao = dep.icao_code
LEFT JOIN cities dep_city ON dep.city_iata_code = dep_city.iata_code
LEFT JOIN countries dep_country ON dep_city.country_iso2 = dep_country.country_iso2
LEFT JOIN airports arr ON f.arrival_icao = arr.icao_code
LEFT JOIN cities arr_city ON arr.city_iata_code = arr_city.iata_code
LEFT JOIN countries arr_country ON arr_city.country_iso2 = arr_country.country_iso2
