#!/bin/bash

# 1. Initialize the files
mkdir -p ./data
mkdir -p ./env
touch ./env/telegraf.env
touch ./env/grafana.env

# 2. Start the InfluxDB
docker compose up influx --detach
sleep 10

# 3. Generate Tokens
TELEGRAF_TOKEN=$(docker exec influx influx auth create --org SKAR --description "Telegraf Token" --write-buckets --json | grep -o '"token": *"[^"]*"' | sed 's/"token": "//' | sed 's/"//g')
GRAFANA_TOKEN=$(docker exec influx influx auth create --org SKAR --description "Grafana Token" --read-buckets --json | grep -o '"token": *"[^"]*"' | sed 's/"token": "//' | sed 's/"//g')

# 4. Stop the InfluxDB container
docker compose down influx

# 5. Configure Telegraf
echo "INFLUX_TOKEN=$TELEGRAF_TOKEN" > ./env/telegraf.env

# 6. Configure Grafana
echo "GF_DATASOURCES_INFLUXDB_TOKEN=$GRAFANA_TOKEN" > ./env/grafana.env