FROM docker.io/prom/node-exporter:v1.11.1

LABEL org.opencontainers.image.authors="jahrik@gmail.com"

ENV NODE_ID=none

COPY --chown=65534:65534 conf /etc/node-exporter/

EXPOSE 9100

ENTRYPOINT ["/etc/node-exporter/docker-entrypoint.sh"]
CMD ["--path.procfs=/host/proc", \
     "--path.sysfs=/host/sys", \
     "--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($|/)", \
     "--collector.textfile.directory=/etc/node-exporter/"]
