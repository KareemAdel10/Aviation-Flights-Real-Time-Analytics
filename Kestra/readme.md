# Kestra in Aviation Real Time Analytics

## Usage in This Project

In this project, Kestra is used to orchestrate the data processing workflows for the Aviation Real Time Analytics. The flow is designed to manage tasks such as data ingestion, transformation, and integration with other platforms like Databricks and Azure Synapse.

### Key Components

* Flow ID and Namespace:
  * `id: Flights-Flow`
  * `namespace: aviation-real-time-analytics`
* Inputs:
  * `flow\_type`: A selectable input to choose between 'Flights' and 'Utility' workflows.
* Variables:
  * Environment and service-specific variables such as `CITIES_ID`, `databricks_token`, `synapse_server`, etc., are used to configure the workflow dynamically.
* Tasks:
  * `If_Flights`: Conditional task that executes if flow\_type is 'Flights'.
    * `Ingest_flights`: Uses a shell script to start and stop the NiFi flow for flights ingestion.
    * `BronzeToSilver_FactTable`: Submits a Databricks job to transform data from Bronze to Silver layer.
    * `Drop_views`: Executes a Python script to drop views in the Synapse database.
    * `build_dbt_project`: Uses a shell script to build and run the dbt project.
    * `SynapseToGoldLayer`: Submits a Databricks job to dumb data from Synapse to the Gold layer and save them as Delta Lkage for historical analysis.
  * `If_Utility`: Conditional task that executes if flow\_type is 'Utility'.
    * `Ingest_cities`: Uses a shell script to start and stop the NiFi flow for flights ingestion.
    * `Ingest_countries`: Uses a shell script to start and stop the NiFi flow for countries ingestion.
    * `Ingest_airplanes`: Uses a shell script to start and stop the NiFi flow for airplanes ingestion.
    * `Ingest_airlines`: Uses a shell script to start and stop the NiFi flow for airlines ingestion.
    * `Ingest_airports`: Uses a shell script to start and stop the NiFi flow for airports ingestion.

### Configuration

The Kestra flow is configured to run tasks using Docker containers, ensuring that each task is isolated and can be executed with the necessary dependencies.
