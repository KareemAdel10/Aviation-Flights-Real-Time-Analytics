# Aviation Real Time Analytics

## Overview

This project is designed to analyze [AviationStack API's ](https://aviationstack.com)data using a combination of tools and platforms including Apache NiFi, Databricks, dbt, Azure Synapse, and Kestra. The project is structured to facilitate data ingestion, transformation, and analysis.

![1743463360325](images/README/1743463360325.png)

![1743463836672](images/README/1743463836672.png)

![1743463922696](images/README/1743463922696.png)

![1743465423408](images/README/1743465423408.png)

## Project Structure

- **Apache NiFi**

  - `NiFi_Flow.json` Contains the flow configuration for data ingestion and processing using Apache NiFi.![1743464017216](images/README/1743464017216.png)

    ![1743464197326](images/README/1743464197326.png)
- **Databricks**

  - `BronzeToSilver_FactTable.ipynb`: Notebook for transforming data from the Bronze to Silver layer for fact tables.
  - `BronzeToSilver_UtilityTables.ipynb`: Notebook for transforming data from the Bronze to Silver layer for utility tables.
  - `SynapseToGoldLayer.ipynb`: Notebook for transforming data from Synapse to the Gold layer.
- **dbt**

  - `dbt_project.yml`: Configuration file for the dbt project.
  - `package-lock.yml` and `packages.yml`: Dependency management files for dbt.
  - `README.md`: Documentation for the dbt project.

    ![1743464268467](images/README/1743464268467.png)
- **Azure Synapse Scripts**

  - SQL scripts for creating and managing external tables in Azure Synapse:
    - `dev script.sql`
    - `External countries table.sql`
    - `External flights table.sql`
    - `External cities table.sql`
    - `External airports table.sql`
    - `External airlines table.sql`
    - `External airplanes table.sql`
- **Kestra**

  - `flow.yml`: Configuration for Kestra workflows.

    ![1743464492364](images/README/1743464492364.png)

    ![1743464636627](images/README/1743464636627.png)
- Power BI:

  - `dashboard.pbix` a dynamic [dashboard](https://app.powerbi.com/links/MTvIODZSbN?ctid=7f3a6ceb-c511-477b-a21a-ea83ceae53d8&pbi\_source=linkShare) that should be refereshed after each flow execution to get the newest insights.
    ![1743465170006](images/README/1743465170006.png)

    ![1743465209975](images/README/1743465209975.png)

## Setup Instructions

1. **Environment Configuration**

   - Ensure you have Docker and Docker Compose installed.
   - Set up environment variables in the `.env` file.
2. **Running the Project**

   - Use the `Makefile` to manage Docker services and NiFi flows.
   - Start services with `make up` and stop them with `make down`.
3. **Data Ingestion and Processing**

   - Use Apache NiFi to manage data flows.
   - Transform data using Databricks notebooks.
   - Use dbt for data modeling and transformation.
4. **Database and Storage**

   - Azure Synapse is used for data storage and processing.
   - Ensure firewall rules are set up as per `main.tf`.
5. **Workflow Orchestration**

   - Use Kestra for orchestrating workflows.

## Additional Information

- **Terraform**: Infrastructure as code is managed using Terraform scripts (`main.tf`).
- **Docker**: Dockerfiles and `docker-compose.yml` are used to containerize and manage services.

## License

This project is licensed under the MIT License.
