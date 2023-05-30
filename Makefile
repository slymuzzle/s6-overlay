PROJECTNAME=slymuzzle/s6-overlay
TAG=UNDEF
ARCHS:=linux/amd64,linux/arm64

.PHONY: all
all: build start test-main test-dev stop clean

build:
	if [ "$(TAG)" = "UNDEF" ]; then echo "Please provide a valid TAG" && exit 1; fi
	docker build --no-cache --pull -t $(PROJECTNAME):$(TAG) -f $(TAG)/Dockerfile $(TAG)

buildx-and-push:
	docker buildx create --use
	docker buildx build --platform $(ARCHS) --push -t $(PROJECTNAME):$(TAG) -f $(TAG)/Dockerfile $(TAG)
	docker buildx stop

start:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker run -d --name s6_overlay_instance $(PROJECTNAME):$(TAG)

stop:
	docker stop -t0 s6_overlay_instance || true
	docker rm s6_overlay_instance || true

clean:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker rmi $(PROJECTNAME):$(TAG) || true

test-main:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi

test-dev:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
