with 

source as (

    select * from {{ source('silver', 'airplanes') }}

),

renamed as (

    select
        {% if var('is_test_run', default=true) %}
            top 100
        {% endif %}    
        registration_number,
        production_line,
        iata_type,
        model_name,
        model_code,
        icao_code_hex,
        iata_code_short,
        construction_number,
        test_registration_number,
        rollout_date,
        first_flight_date,
        delivery_date,
        registration_date,
        line_number,
        plane_series,
        airline_iata_code,
        airline_icao_code,
        plane_owner,
        engines_count,
        engines_type,
        plane_age,
        plane_status,
        plane_class

    from source

)

select * from renamed
