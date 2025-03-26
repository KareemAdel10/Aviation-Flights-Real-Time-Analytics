with 

source as (

    select * from {{ source('silver', 'airlines') }}

),

renamed as (

    select
        {% if var('is_test_run', default=False) %}
            top 100
        {% endif %}    
        airline_name,
        icao_code,
        iata_code,
        iata_prefix_accounting,
        callsign,
        type,
        status,
        fleet_size,
        fleet_average_age,
        date_founded,
        hub_code,
        country_name,
        country_iso2

    from source

)

select * from renamed
