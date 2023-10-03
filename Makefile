DOCKER := $(shell { command -v podman || command -v docker; })

.PHONY: all clean distclean

all:
	$(DOCKER) build --tag zmk --build-arg USER_ID=$(shell id -u) .
	$(DOCKER) volume create build
	$(DOCKER) run --rm -it --name zmk \
		-v build:/app \
		-v $(PWD)/build.yaml:/app/build.yaml:ro \
		-v $(PWD)/config:/app/config:ro \
		-v $(PWD)/firmware:/app/firmware \
		-e OUTPUT_ZMK_CONFIG=$(OUTPUT_ZMK_CONFIG) \
		zmk

clean:
	rm -rf firmware/[^.]*
	-$(DOCKER) volume rm build config firmware

distclean: clean
	-$(DOCKER) image rm zmk
