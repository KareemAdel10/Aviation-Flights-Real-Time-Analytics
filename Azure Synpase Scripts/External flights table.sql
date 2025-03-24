IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDeltaFormat') 
    CREATE EXTERNAL FILE FORMAT [SynapseDeltaFormat] 
    WITH ( FORMAT_TYPE = DELTA);
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'AviationDataLake') 
    CREATE EXTERNAL DATA SOURCE [AviationDataLake] 
    WITH (
        LOCATION = 'abfss://silver@aviationdatalake.dfs.core.windows.net' 
    );
GO

CREATE EXTERNAL TABLE silver.flights (
    flight_date nvarchar(4000),
    flight_status nvarchar(4000),
    
    departure_airport nvarchar(4000),
    departure_timezone nvarchar(4000),
    departure_iata nvarchar(4000),
    departure_icao nvarchar(4000),
    departure_terminal nvarchar(4000),
    departure_gate nvarchar(4000),
    departure_delay INT,
    departure_scheduled nvarchar(4000),
    departure_estimated nvarchar(4000),
    departure_actual nvarchar(4000),
    departure_estimated_runway nvarchar(4000),
    departure_actual_runway nvarchar(4000),
    
    arrival_airport nvarchar(4000),
    arrival_timezone nvarchar(4000),
    arrival_iata nvarchar(4000),
    arrival_icao nvarchar(4000),
    arrival_terminal nvarchar(4000),
    arrival_gate nvarchar(4000),
    arrival_baggage nvarchar(4000),
    arrival_delay INT,
    arrival_scheduled nvarchar(4000),
    arrival_estimated nvarchar(4000),
    arrival_actual nvarchar(4000),
    arrival_estimated_runway nvarchar(4000),
    arrival_actual_runway nvarchar(4000),
    
    airline_name nvarchar(4000),
    airline_iata nvarchar(4000),
    airline_icao nvarchar(4000),
    
    flight_number INT,
    flight_iata nvarchar(4000),
    flight_icao nvarchar(4000),
    flight_codeshared nvarchar(4000),
    
    aircraft_registration nvarchar(4000),
    aircraft_iata nvarchar(4000),
    aircraft_icao nvarchar(4000),
    aircraft_icao24 nvarchar(4000),
    
    live_updated nvarchar(4000),
    live_latitude FLOAT,
    live_longitude FLOAT,
    live_altitude FLOAT,
    live_direction FLOAT,
    live_speed_horizontal FLOAT,
    live_speed_vertical FLOAT,
    live_is_ground BIT
)
WITH (
    LOCATION = 'silver/flights/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.flights;
GO

