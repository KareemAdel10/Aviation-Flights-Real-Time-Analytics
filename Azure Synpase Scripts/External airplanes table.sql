IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDeltaFormat') 
    CREATE EXTERNAL FILE FORMAT [SynapseDeltaFormat] 
    WITH ( FORMAT_TYPE = DELTA );
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'AviationDataLake') 
    CREATE EXTERNAL DATA SOURCE [AviationDataLake] 
    WITH (
        LOCATION = 'abfss://silver@aviationdatalake.dfs.core.windows.net' 
    );
GO

CREATE EXTERNAL TABLE silver.airplanes (
    registration_number NVARCHAR(50),
    production_line NVARCHAR(100),
    iata_type NVARCHAR(100),
    model_name NVARCHAR(100),
    model_code NVARCHAR(50),
    icao_code_hex NVARCHAR(10),
    iata_code_short NVARCHAR(10),
    construction_number NVARCHAR(50),
    test_registration_number NVARCHAR(50),
    rollout_date NVARCHAR(50),
    first_flight_date NVARCHAR(50),
    delivery_date NVARCHAR(50),
    registration_date NVARCHAR(50),
    line_number NVARCHAR(50),
    plane_series NVARCHAR(50),
    airline_iata_code NVARCHAR(10),
    airline_icao_code NVARCHAR(10),
    plane_owner NVARCHAR(255),
    engines_count INT,
    engines_type NVARCHAR(100),
    plane_age INT,
    plane_status NVARCHAR(100),
    plane_class NVARCHAR(100)
)
WITH (
    LOCATION = 'silver/airplanes/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.airplanes;
GO
