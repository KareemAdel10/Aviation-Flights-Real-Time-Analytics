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

CREATE EXTERNAL TABLE silver.airlines (
    airline_name NVARCHAR(255),
    icao_code NVARCHAR(10),
    iata_code NVARCHAR(10),
    iata_prefix_accounting NVARCHAR(10),
    callsign NVARCHAR(50),
    type NVARCHAR(50),
    status NVARCHAR(50),
    fleet_size INT,
    fleet_average_age FLOAT,
    date_founded INT,
    hub_code NVARCHAR(10),
    country_name NVARCHAR(255),
    country_iso2 CHAR(5)
)
WITH (
    LOCATION = 'silver/airlines/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.airlines;
GO
