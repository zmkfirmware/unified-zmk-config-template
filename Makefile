DOCKER := $(shell { command -v podman || command -v docker; })

.PHONY: all clean distclean

all:
	$(DOCKER) zmk_build --tag zmk-config --build-arg USER_ID=$(shell id -u) .
	$(DOCKER) volume create zmk_app
	$(DOCKER) run --rm -it --name zmk-config -u zmk \
		-v zmk_app:/app \
		-v $(PWD)/build.yaml:/app/build.yaml:ro \
		-v $(PWD)/config:/app/config:ro \
		-v $(PWD)/firmware:/app/firmware \
		-e OUTPUT_ZMK_CONFIG=$(OUTPUT_ZMK_CONFIG) \
		zmk-config

clean:
	rm -rf firmware/[^.]*
	-$(DOCKER) volume rm build config firmware
	-$(DOCKER) volume rm zmk_app

distclean: clean
	-$(DOCKER) image rm zmk-config
