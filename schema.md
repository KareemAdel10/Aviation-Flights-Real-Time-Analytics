## Fact Table:

- fact_flights Table:
  - flight_id (UID)
  - flight_number
  - flight_iata
  - flight_icao
  - flight_data
  - flight_status
  - departure_icao (Foreign Key to Airports Dimension)
  - departure_iata
  - departure_terminal
  - departure_gate
  - departure_scheduled
  - departure_actual
  - departure_delay
  - arrival_icao (Foreign Key to Airports Dimension)
  - arrival_iata
  - arrival_terminal
  - arrival_gate
  - arrival_baggage
  - arrival_scheduled
  - arrival_actual
  - arrival_delay
  - airline_icao (Foreign Key to Airlines Dimension)
  - aircraft_registration (Foreign Key to Aircraft Dimension)
  - aircraft_iata
  - live_longitude
  - live_altitude
  - live_is_ground

## Dimension Tables:

- dim_airports:
  - airport_id (UID)
  - airline_name
  - iata_code
  - icao_code
  - latitude
  - longitude
  - timezone
  - country_iso2
  - country_name
  - city_iata_code
- dim_airlines:
  - airline_id (UID)
  - airline_name
  - icao_code
  - iata_code
  - iata_prefix_accounting
  - country_iso2
  - country_name
  - callsign
  - fleet_size
  - fleet_average_age
  - date_founded
  - status
  - type
- dim_airplanes:
  - airplane_id (UID)
  - registration_number
  - model_name
  - model_code
  - plane_owner
  - construction_number
  - production_line
  - iata_type
  - first_flight_date
  - delivery_date
  - plane_series
  - engines_count
  - engines_type
  - plane_age
  - plane_status
- Cities Dimension:
  - city_id (UID)
  - city_name
  - iata_code
  - Latitude
  - Longitude
  - Timezone
  - country_iso2
- Countries Dimension:
  - country_id (UID)
  - country_name
  - country_ISO2
  - capital
  - continent
  - currency_name
  - population
  - phone_prefix

## Used Endpoints:

[AviationStack API Documentation for Historical Flight Data & Tracking](https://aviationstack.com/documentation)

1. Flights Endpoint: Use this to populate the Flights Fact Table and link to dimension tables.
2. Airlines Endpoint: Use this to populate the Airlines Dimension. => 13140
3. Airports Endpoint: Use this to populate the Airports Dimension. => 6710
4. Airplanes Endpoint: Use this to populate the Aircraft Dimension. => 19052
5. Cities Endpoint: Use this to populate the Cities Dimension. => 9368
6. Countries Endpoint: Use this to populate the Countries Dimension. =>252
