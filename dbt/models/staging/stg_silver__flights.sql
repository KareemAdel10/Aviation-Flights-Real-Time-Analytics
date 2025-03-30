with 

source as (

    select * from {{ source('silver', 'flights') }}

),

renamed as (

    select
        {% if var('is_test_run', default=False) %}
            top 100
        {% endif %}
        flight_date,
        flight_status,
        departure_airport,
        departure_timezone,
        departure_iata,
        departure_icao,
        departure_terminal,
        departure_gate,
        departure_delay,
        departure_scheduled,
        departure_estimated,
        departure_actual,
        departure_estimated_runway,
        departure_actual_runway,
        arrival_airport,
        arrival_timezone,
        arrival_iata,
        arrival_icao,
        arrival_terminal,
        arrival_gate,
        arrival_baggage,
        arrival_delay,
        arrival_scheduled,
        arrival_estimated,
        arrival_actual,
        arrival_estimated_runway,
        arrival_actual_runway,
        airline_name,
        airline_iata,
        airline_icao,
        flight_number,
        flight_iata,
        flight_icao,
        flight_codeshared,
        aircraft_registration,
        aircraft_iata,
        aircraft_icao,
        aircraft_icao24,
        live_updated,
        live_latitude,
        live_longitude,
        live_altitude,
        live_direction,
        live_speed_horizontal,
        live_speed_vertical,
        live_is_ground

    from source

)

select * from renamed
