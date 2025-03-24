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

CREATE EXTERNAL TABLE silver.countries (
    country_name NVARCHAR(255),
    country_iso2 CHAR(2),
    country_iso3 CHAR(3),
    country_iso_numeric INT,
    population BIGINT,
    capital NVARCHAR(255),
    continent NVARCHAR(100),
    currency_name NVARCHAR(100),
    currency_code CHAR(3),
    fips_code NVARCHAR(10),
    phone_prefix NVARCHAR(24)
)
WITH (
    LOCATION = 'silver/countries/',
    DATA_SOURCE = [AviationDataLake],
    FILE_FORMAT = [SynapseDeltaFormat]
);
GO

SELECT TOP 10 * FROM silver.countries;
GO

