WITH flights AS(
    SELECT 
        *
    FROM 
        {{ ref('stg_silver__flights') }}
)
SELECT 
    {% if var('is_test_run', default=False) %}
        top 10
    {% endif %}  
    
    ROW_NUMBER() OVER(ORDER BY flight_number, flight_iata, flight_icao, flight_status) AS flight_id, --pk

    -- Flight attributes
    flight_number, 
    flight_iata, 
    flight_icao,
    flight_date,
    flight_status,

    -- Departure attributes
    departure_icao, -- fk
    departure_iata,
    departure_terminal,
    departure_gate,
    departure_scheduled,
    departure_actual,
    departure_delay,

    -- Arrival attributes
    arrival_icao, -- fk
    arrival_iata,
    arrival_terminal,
    arrival_gate,
    arrival_baggage,
    arrival_scheduled,
    arrival_actual,
    arrival_delay,

    -- Airline attributes
    airline_name,
    airline_iata,
    airline_icao,
    
    -- Aircraft attributes
    aircraft_registration,
    aircraft_iata,
    aircraft_icao,
    aircraft_icao24,

    -- Live attributes
    live_longitude,
    live_altitude,
    CASE
        WHEN live_speed_horizontal > 0  and live_speed_vertical > 0 THEN 'False'
        ELSE 'True'
    END  AS live_is_ground

FROM 
    flights 
    