# arm-node-exporter

[![Build](https://github.com/jahrik/arm-node-exporter/actions/workflows/build.yml/badge.svg)](https://github.com/jahrik/arm-node-exporter/actions/workflows/build.yml)

Multi-arch [node_exporter](https://github.com/prometheus/node_exporter) image for the `monitor` swarm stack. A pinned layer over the official `prom/node-exporter` image plus a `node_meta` metric (swarm node ID + hostname) for dashboard labels.

## Run

```bash
docker run -d -p 9100:9100 -v /proc:/host/proc:ro -v /sys:/host/sys:ro \
  -v /etc/hostname:/etc/nodename:ro jahrik/arm-node-exporter:latest
curl http://localhost:9100/metrics | grep node_meta
```

## Deploy (swarm)

```bash
docker network create -d overlay monitor   # once
make deploy                                # global service, stack: monitor
```

## Build

```bash
make build
make push
```

CI: PR builds + metrics/node_meta check; merge to main pushes multi-arch (amd64/arm64/armv7) to Docker Hub.
