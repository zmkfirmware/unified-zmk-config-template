FROM docker.io/zmkfirmware/zmk-build-arm:stable

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64 -O /usr/bin/yq \
    && chmod +x /usr/bin/yq

ARG USER_ID=1000

RUN adduser --disabled-password --gecos '' --uid ${USER_ID} zmk

USER zmk

WORKDIR /app

COPY config/west.yml config/west.yml

RUN mkdir -p build \
    && west init -l config \
    && west update \
    && west zephyr-export

COPY bin/build.sh ./

CMD ["./build.sh"]
