# Sirius Telemetry Setup

## Initial configuration
1. Run the setup script to execute all commands
```sh
sudo scripts/setup.sh
```
2. Run the system
```sh
sudo docker compose up --detach
```

## Setup Grafana
1. Open the Granafa `http://influx:8086`
2. Go to `datasources`
3. Click button `Add data source`
4. Select `InfluxDB`
5. In **Query Language**:
   - select query language to "Flux"
6. In **HTTP** section:
   - url: `http://localhost:3000`
7. In **InfluxDB Details** section:
   - organization: `SKAR`
   - read token from file `./env/grafana.env`
   - default bucket: `sirius`
8. Click button `Save`