IMAGE = "jahrik/node-exporter"
TAG := $(shell uname -m)
STACK = "monitor"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	# FIXME
	# "unsupported platform on 1 node"
	# jahrik/node-exporter:aarch64
	# @docker stack deploy -c docker-compose.yml ${STACK}
	@docker stack deploy --resolve-image=never --with-registry-auth -c docker-compose.yml ${STACK}

.PHONY: all build push deploy
