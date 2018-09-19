FROM ubuntu:xenial

RUN apt-get update && apt-get install -qq -y wget

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get install -qq -y  \
      git \
      wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*


ENV XMRIG_VERSION=2.6.4 XMRIG_SHA256=34d390a499d2098bce92e6b85b4858ee6255a7e2d4e03197ba4f6a759efe349c

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "-u=45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN", "-p=Docker", "-k", "--max-cpu-usage=100", "--donate-level=1"]
