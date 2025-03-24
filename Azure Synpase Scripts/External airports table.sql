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

CREATE EXTERNAL TABLE silver.airports (
    airport_name NVARCHAR(255),
    iata_code NVARCHAR(10),
    icao_code NVARCHAR(10),
    latitude FLOAT,
    longitude FLOAT,
    geoname_id BIGINT,
    timezone NVARCHAR(100),
    gmt NVARCHAR(10),
    phone_number NVARCHAR(50),
    country_name NVARCHAR(255),
    country_iso2 CHAR(5),
    city_iata_code NVARCHAR(10)
)
WITH (
    LOCATION = 'silver/airports/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.airports;
GO
