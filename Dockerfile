FROM ubuntu:xenial

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get install -qq -y  \
      git \
      wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV XMRIG_VERSION=2.8.3 XMRIG_SHA256=365198ed4f1205c42fa448d41c9088d3dea6bff43173c5e870e8bec4631c3a7d

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--algo=cryptonight", "--url=stratum+tcp://pool.supportxmr.com:5555", "--user=45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN", "--pass=Docker", "-k", "--max-cpu-usage=100", "--donate-level=1"]
