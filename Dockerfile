FROM arm32v7/ubuntu
LABEL maintainer "Jahrik <jahrik@gmail.com>"
# ARG ARCH=arm64
ARG ARCH=armv7
ARG VERSION=0.16.0

RUN apt-get update
RUN apt-get install -y \
  wget \
  ca-certificates
RUN mkdir -p /tmp/install
RUN wget -O /tmp/install/node_exporter.tar.gz https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-$ARCH.tar.gz
RUN apt-get install -y libc6-compat
RUN cd /tmp/install \
  && tar --strip-components=1 -xzf node_exporter.tar.gz \
  && mv node_exporter /bin/node_exporter
RUN rm -rf /tmp/install

EXPOSE     9100
ENTRYPOINT ["/bin/node_exporter"]
CMD ["--path.procfs", "/host/proc", "--path.sysfs", "/host/sys", "--collector.filesystem.ignored-mount-points", "\"^/(sys|proc|dev|host|etc)($|/)\""]
