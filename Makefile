include .env

PLATFORM ?= linux/amd64

TARGET_MAX_CHAR_NUM=20

# Define Process Group IDs for NiFi Flows
export CITIES_ID ?=$(CITIES_ID)
export COUNTRIES_ID ?=$(COUNTRIES_ID)
export AIRPLANES_ID ?=$(AIRPLANES_ID)
export AIRPORTS_ID ?=$(AIRPORTS_ID)
export AIRLINES_ID ?=$(AIRLINES_ID)
export FLIGHTS_ID ?=$(FLIGHTS_ID)

export user ?=$(user)
export password ?=$(password)
export token ?=$(token)

## Show help with make help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  make <target>'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  %-$(TARGET_MAX_CHAR_NUM)s %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

# Docker
.PHONY: up
## Starts the Docker Compose services
up:
	docker compose up -d

.PHONY: down
## Stops and removes the Docker Compose services
down:
	docker compose down

# NiFi
.PHONY: token
## get new NiFi token
token:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -X POST -H "Content-Type: application/x-www-form-urlencoded" -d 'username=$(user)&password=$(password)' https://localhost:8443/nifi-api/access/token

# Cities commands
.PHONY: cities-up
## Runs then stops the Cities ingestion flow
cities-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(CITIES_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(CITIES_ID)
	sleep 100
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(CITIES_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(CITIES_ID)

.PHONY: cities-run
## Runs the Cities ingestion flow
cities-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(CITIES_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(CITIES_ID)

.PHONY: cities-stop
## Stops the Cities ingestion flow
cities-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(CITIES_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(CITIES_ID)

# Countries commands
.PHONY: countries-up
## Runs then stops the Countries ingestion flow
countries-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(COUNTRIES_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(COUNTRIES_ID)
	sleep 25
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(COUNTRIES_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(COUNTRIES_ID)

.PHONY: countries-run
## Runs the Countries ingestion flow
countries-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(COUNTRIES_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(COUNTRIES_ID)

.PHONY: countries-stop
## Stops the Countries ingestion flow
countries-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(COUNTRIES_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(COUNTRIES_ID)

# Airplanes commands
.PHONY: airplanes-up
## Runs then stops the Airplanes ingestion flow
airplanes-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRPLANES_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPLANES_ID)
	sleep 200
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRPLANES_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPLANES_ID)

.PHONY: airplanes-run
## Runs the Airplanes ingestion flow
airplanes-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRPLANES_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPLANES_ID)

.PHONY: airplanes-stop
## Stops the Airplanes ingestion flow
airplanes-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRPLANES_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPLANES_ID)

# Airports commands
.PHONY: airports-up
## Runs then stops the Airports ingestion flow
airports-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRPORTS_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPORTS_ID)
	sleep 100
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRPORTS_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPORTS_ID)

.PHONY: airports-run
## Runs the Airports ingestion flow
airports-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRPORTS_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPORTS_ID)

.PHONY: airports-stop
## Stops the Airports ingestion flow
airports-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRPORTS_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRPORTS_ID)

# Airlines commands
.PHONY: airlines-up
## Runs then stops the Airlines ingestion flow
airlines-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRLINES_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRLINES_ID)
	sleep 200
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(AIRLINES_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRLINES_ID)

.PHONY: airlines-run
## Runs the Airlines ingestion flow
airlines-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRLINES_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRLINES_ID)

.PHONY: airlines-stop
## Stops the Airlines ingestion flow
airlines-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(AIRLINES_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(AIRLINES_ID)

# Flights commands
.PHONY: flights-up
## Runs then stops the Flights ingestion flow
flights-up:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(FLIGHTS_ID)","state":"RUNNING"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(FLIGHTS_ID)
	sleep 100
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 \
		-H "Authorization: Bearer $(token)" \
		-H "Content-Type: application/json" \
		-d '{"id":"$(FLIGHTS_ID)","state":"STOPPED"}' \
		-X PUT https://localhost:8443/nifi-api/flow/process-groups/$(FLIGHTS_ID)

.PHONY: flights-run
## Runs the Flights ingestion flow
flights-run:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(FLIGHTS_ID)","state":"RUNNING"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(FLIGHTS_ID)

.PHONY: flights-stop
## Stops the Flights ingestion flow
flights-stop:
	docker compose exec nifi curl -k -v --resolve localhost:8443:192.168.65.254 -H "Authorization: Bearer $(token)" -H "Content-Type: application/json" -d '{"id":"$(FLIGHTS_ID)","state":"STOPPED"}' -X PUT https://localhost:8443/nifi-api/flow/process-groups/$(FLIGHTS_ID)

# Kestra
.PHONY: kestra-flights
## Runs the Kestra workflow
kestra-flights:
	curl -v -X POST -H 'Content-Type: multipart/form-data' -F 'flow_type=Flights' 'http://localhost:8080/api/v1/executions/aviation-real-time-analytics/Flights-Flow'

# Kestra
.PHONY: kestra-utility
## Runs the Kestra workflow
kestra-flights:
	curl -v -X POST -H 'Content-Type: multipart/form-data' -F 'flow_type=Utility' 'http://localhost:8080/api/v1/executions/aviation-real-time-analytics/Flights-Flow'