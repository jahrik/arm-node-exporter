# AGENTS.md

Multi-arch node_exporter image: pinned `FROM` over official `prom/node-exporter` plus an entrypoint that writes a `node_meta` textfile metric (swarm `NODE_ID` + hostname), deployed global in the `monitor` swarm stack.

## Commands

```bash
make build                                  # build jahrik/arm-node-exporter:latest
docker run -d -p 9100:9100 -v /etc/hostname:/etc/nodename:ro jahrik/arm-node-exporter:latest
make deploy                                 # swarm stack deploy (stack: monitor)
```

## CI

`build.yml`: Test (build + `/metrics` poll grepping `node_meta`) on PR; Release (buildx amd64/arm64/armv7 push to Docker Hub) on merge to main. Needs `DOCKERHUB_USERNAME`/`DOCKERHUB_TOKEN` secrets.

## Quirks

- Bump node_exporter via the `FROM` tag.
- The entrypoint needs `/etc/nodename` mounted (hostname) and writes `node-meta.prom` into `/etc/node-exporter/` — that dir is chowned to 65534 (nobody) at build.
- Flag rename since 0.16: `--collector.filesystem.mount-points-exclude` (was `ignored-mount-points`).
- Image was previously pushed as `jahrik/node-exporter`; CI now pushes `jahrik/arm-node-exporter` to match the repo.
- External `monitor` overlay network — keep that wiring.
