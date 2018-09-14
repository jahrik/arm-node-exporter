IMAGE = "jahrik/arm-node-exporter"
TAG = "arm32v7"

all: build

build:
	@docker build -t ${IMAGE}:$(TAG) ./docker
	@docker tag ${IMAGE}:$(TAG) ${IMAGE}:latest

push:
	@docker push ${IMAGE}:$(TAG)
	@docker push ${IMAGE}:latest

deploy:
	@docker stack deploy --resolve-image=never -c node-exporter-stack.yml node

.PHONY: all build push deploy
