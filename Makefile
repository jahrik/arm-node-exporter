IMAGE = "jahrik/node-exporter"
TAG := $(shell uname -m)
STACK = "monitor"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) -f Dockerfile_${TAG} .

push:
	@docker push ${IMAGE}:$(TAG)

deploy:
	# @docker stack deploy --resolve-image=never -c docker-compose.yml ${STACK}
	@docker stack deploy -c docker-compose.yml ${STACK}

.PHONY: all build push deploy
