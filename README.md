# Unified ZMK Config

## Modifying the keymap

[The ZMK documentation](https://zmk.dev/docs) covers both basic and advanced functionality and has a table of OS compatibility for keycodes.

## Building the Firmware with GitHub Actions

### Setup

1. Fork this repo.
2. Enable GitHub Actions on your fork.

### Build firmware

1. Push a commit to trigger the build.
2. Download the artifact.

## Building the Firmware in a local container

### Setup

#### Software

* Either Podman or Docker is required, Podman is preferred if both are present.
* `make` is also required

#### Windows specific

* If compiling on Windows use WSL2 and Docker [Docker Setup Guide](https://docs.docker.com/desktop/windows/wsl/).
* Install `make` using
    ```bash
    sudo apt-get install make
    ```.
* The repository can be cloned directly into the WSL2 instance or accessed through the C: mount point WSL provides by default (`/mnt/c/path-to-repo`).

### Build firmware

1. Execute `make`.
2. Check the `firmware` directory for the latest firmware build.

#### Output ZMK Configs
Sometimes it can be useful to output the full ZMK configs for a build. This can be achieved by executing the following:
```bash
OUTPUT_ZMK_CONFIG=1 make
```

The configs with then be outputted to the `firmware` directory along with the firmware files.

#### Build Cache
A docker volume is used to cache the build artifacts, allowing subsequent builds to compile faster.

### Cleanup

#### Partial Cleanup
The compiled firmware files and docker volume build cache can be deleted with `make clean`. This might be necessary if you want a pristine build or to cleanup the `firmware` directory.

### Full Cleanup

The built docker container can be deleted with `make distclean`. This might be necessary if you want to rebuild the docker container or update the ZMK version used to compile your firmware.

Of course, you can also use regular Docker commands to manage the image/build cache.

## Flashing firmware

Follow the ZMK instructions on [Flashing UF2 Files](https://zmk.dev/docs/user-setup#flashing-uf2-files) to flash the firmware.
