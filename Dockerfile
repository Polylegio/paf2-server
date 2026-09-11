FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        libcurl4-openssl-dev \
        libjsoncpp-dev \
        libpq-dev \
        rapidjson-dev \
        libsrt-openssl-dev \
        libssl-dev \
        pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .

RUN chmod +x build.sh \
    && mkdir -p paftransfer/obj paftransfer/bin \
    && printf "3\n" | ./build.sh \
    && install -m 0755 paftransfer/bin/pafserver /usr/local/bin/pafserver

COPY docker-entrypoint.sh /usr/local/bin/pafserver-entrypoint
RUN chmod +x /usr/local/bin/pafserver-entrypoint

EXPOSE 8000/udp

ENTRYPOINT ["pafserver-entrypoint"]
CMD ["pafserver"]
