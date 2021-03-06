# docker-compose.yml
version: '2'
services:
prometheus:
image: prom/prometheus:latest
volumes:
- ./prometheus.yml:/etc/prometheus/prometheus.yml
- ./alert.rules:/etc/prometheus/alert.rules
- ./prometheus_db:/var/lib/prometheus
command:
- '-config.file=/etc/prometheus/prometheus.yml'
- '-alertmanager.url=http://52.220.226.1:9093'
ports:
- '9090:9090'
node-exporter:
image: prom/node-exporter
ports:
- '9100:9100'
grafana:
image: grafana/grafana
environment:
- GF_SECURITY_ADMIN_PASSWORD=admin_pass
depends_on:
- prometheus
ports:
- '3000:3000'
#volumes:
#- ./grafana_db:/var/lib/grafana
alertmanager:
image: prom/alertmanager:latest
volumes:
- ./alertmanager.yml:/alertmanager.yml
command:
- '-config.file=/alertmanager.yml'
ports:
- '9093:9093'
