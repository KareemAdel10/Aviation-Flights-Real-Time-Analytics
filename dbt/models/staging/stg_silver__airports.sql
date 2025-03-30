with 

source as (

    select * from {{ source('silver', 'airports') }}

),

renamed as (

    select
        {% if var('is_test_run', default=False) %}
            top 100
        {% endif %}    
        airport_name,
        iata_code,
        icao_code,
        latitude,
        longitude,
        geoname_id,
        timezone,
        gmt,
        phone_number,
        country_name,
        country_iso2,
        city_iata_code

    from source

)

select * from renamed
