# Apache NiFi in Aviation Real Time Analytics Analysis

## What is Apache NiFi?

Apache NiFi is a powerful data integration tool that provides an easy-to-use, highly configurable, and scalable platform for data routing, transformation, and system mediation logic. It is designed to automate the flow of data between software systems and is often used for data ingestion, transformation, and delivery.

## Usage in This Project

In this project, Apache NiFi is used to invoke HTTP requests to the AviationStack API. The flow is designed to manage data ingestion from the API, process the data, and prepare it for further analysis. The flow utilizes multiple processors to achieve this purpose.

### Key Components

* Process Groups:
  * `Flights-Ingestion-Flow`: This is the main process group responsible for ingesting data related to real time flights.
  * `Cities-Ingestion-Flow`: This is one of the utility process groups responsible for ingesting data related to cities.
  * `Countries-Ingestion-Flow`: This is one of the utility process groups responsible for ingesting data related to countries.
  * `Airplanes-Ingestion-Flow`: This is one of the utility process groups responsible for ingesting data related to Airplanescities.
  * `Airlines-Ingestion-Flow`: This is one of the utility process groups responsible for ingesting data related to Airlines.
  * `Airports-Ingestion-Flow`: This is one of the utility process groups responsible for ingesting data related to Airports.
* Processors:
  * ExecuteStreamCommand: Executes shell commands to interact with the API.
    * Command Path: /bin/bash
    * Command Arguments: Utilizes curl to make HTTP requests with specific headers and data.
  * UpdateAttribute: Updates flow file attributes to manage state and data flow.
    * Properties: Includes expressions for managing offsets and state.
  * RouteOnAttribute: Routes flow files based on attribute values.
    * Properties: Configured to route based on conditions like lessThan and autoTerminate.
  * EvaluateJsonPath: Extracts JSON attributes from flow files.
    * Properties: Configures JSON path expressions to extract pagination details.
  * InvokeHTTP: Makes HTTP requests to external services.
    * Properties: Configured for HTTP/2, request encoding, and response handling.

### Parameters and Variables

* bearer.token: Used for authorization in HTTP requests.
* Pagination Attributes:
  * current.offset, total, count\_: Used to manage and track pagination in API responses.

## Configuration

The flow is configured to run on a timer-driven scheduling strategy, with processors set to handle retries and backoff mechanisms to ensure robust data flow management.
