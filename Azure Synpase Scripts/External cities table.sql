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

CREATE EXTERNAL TABLE silver.cities (
    city_name NVARCHAR(255),
    iata_code NVARCHAR(10),
    country_iso2 CHAR(2),
    latitude FLOAT,
    longitude FLOAT,
    timezone NVARCHAR(100),
    gmt NVARCHAR(10) ,
    geoname_id BIGINT
)
WITH (
    LOCATION = 'silver/cities/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.cities;
GO
