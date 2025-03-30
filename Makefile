PLATFORM ?= linux/amd64

TARGET_MAX_CHAR_NUM=20

# Define Process Group IDs for NiFi Flows
CITIES_ID=4d216316-95de-3aa4-fe3f-f6952721a841
COUNTRIES_ID=708eba99-c9b9-3333-01b7-b124e0f9418e
AIRPLANES_ID=6e2fe909-bb5a-364c-a796-2861040c9bf7
AIRPORTS_ID=a2c8710c-6568-3c61-ead6-148196f6e92f
AIRLINES_ID=6fabbfa9-59e9-386f-821f-829ddcc37d10
FLIGHTS_ID=a9776459-0195-1000-3fe9-0bf199022bf6

user=admin
password=ctsBtRBKHRAx69EqUghvvgEvjnaLjFEB
token=eyJraWQiOiJhOGM3NzdlZC1hOTQzLTRkMWUtYWJhMy0wZGU4OGY4OTU3OGIiLCJhbGciOiJFZERTQSJ9.eyJzdWIiOiJhZG1pbiIsImF1ZCI6Imh0dHBzOi8vNGViNTk2ZmIyZDlhOjg0NDMiLCJuYmYiOjE3NDMyODA3NjgsImlzcyI6Imh0dHBzOi8vNGViNTk2ZmIyZDlhOjg0NDMiLCJncm91cHMiOltdLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhZG1pbiIsImV4cCI6MTc0MzMwOTU2OCwiaWF0IjoxNzQzMjgwNzY4LCJqdGkiOiI4ZGY1YzI1NC00YTI5LTQzNDgtYWY5Yy02MmZjMzExOGI5OGMifQ.qjIKDOx9jctdD0L9ZC7K2vDiW_X30N7LZlnxZO1rZoWBWCLnhIDNw7L2BZ925oQ0PrSV0iliay13dV-kVr8lCg

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
.PHONY: kestra
## Runs the Kestra workflow
kestra:
	docker compose exec kestra /bin/bash -c "kestra executions start --namespace=aviation --flow=aviation-flow"