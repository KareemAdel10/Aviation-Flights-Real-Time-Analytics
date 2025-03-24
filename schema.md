## Fact Table:

- Flights Fact Table:
  - Flight ID (Primary Key)
  - Flight Date
  - Flight Status
  - Departure Airport Code (Foreign Key to Airports Dimension)
  - Arrival Airport Code (Foreign Key to Airports Dimension)
  - Airline Code (Foreign Key to Airlines Dimension)
  - Aircraft Registration (Foreign Key to Aircraft Dimension)
  - Departure Delay
  - Arrival Delay
  - Scheduled Departure Time
  - Actual Departure Time
  - Scheduled Arrival Time
  - Actual Arrival Time

## Dimension Tables:

- Airlines Dimension:
  - Airline Code (Primary Key)
  - Airline Name
  - IATA Code
  - ICAO Code
  - Country Name
  - Country ISO2
- Airports Dimension:
  - Airport Code (Primary Key)
  - Airport Name
  - IATA Code
  - ICAO Code
  - Latitude
  - Longitude
  - Timezone
  - Country Name
  - Country ISO2
- Airplanes Dimension:
  - Aircraft Registration (Primary Key)
  - IATA Type
  - Model Name
  - Model Code
  - Plane Age
  - Plane Status
- Cities Dimension:
  - City Code (Primary Key)
  - City Name
  - Country ISO2
  - Latitude
  - Longitude
  - Timezone
- Countries Dimension:
  - Country ISO2 (Primary Key)
  - Country Name
  - Country ISO3
  - Continent
  - Currency Code
  - Population

## The Endpoints Used:

1. Flights Endpoint: Use this to populate the Flights Fact Table and link to dimension tables.
2. Airlines Endpoint: Use this to populate the Airlines Dimension. => 13139
3. Airports Endpoint: Use this to populate the Airports Dimension. => 6710
4. Airplanes Endpoint: Use this to populate the Aircraft Dimension. => 19052
5. Cities Endpoint: Use this to populate the Cities Dimension. => 9368
6. Countries Endpoint: Use this to populate the Countries Dimension. =>252
