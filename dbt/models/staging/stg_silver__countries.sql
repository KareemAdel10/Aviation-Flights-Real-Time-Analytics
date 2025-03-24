with 

source as (

    select * from {{ source('silver', 'countries') }}

),

renamed as (

    select
        {% if var('is_test_run', default=true) %}
            top 100
        {% endif %}
        country_name,
        country_iso2,
        country_iso3,
        country_iso_numeric,
        population,
        capital,
        continent,
        currency_name,
        currency_code,
        fips_code,
        phone_prefix

    from source

)

select * from renamed
