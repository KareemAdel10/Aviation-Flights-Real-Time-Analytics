with 

source as (

    select * from {{ source('silver', 'cities') }}

),

renamed as (

    select
        {% if var('is_test_run', default=False) %}
            top 100
        {% endif %}
        city_name,
        iata_code,
        country_iso2,
        latitude,
        longitude,
        timezone,
        gmt,
        geoname_id

    from source

)

select * from renamed
