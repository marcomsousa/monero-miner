FROM ubuntu:focal

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get install -qq -y  \
      git \
      wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV XMRIG_VERSION=6.5.1 
ENV XMRIG_SHA256=9a93a4504aa3622a86ddbf6051d163d873067dd951301af5162ddb72dfd13af2 
ENV UBUNTU_VERSION=focal
ENV FILENAME=xmrig-${XMRIG_VERSION}-${UBUNTU_VERSION}-x64.tar.gz

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/${FILENAME} &&\
  echo "${XMRIG_SHA256}  ${FILENAME}" | sha256sum -c - &&\
  tar -xvzf ${FILENAME} &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION}

ENTRYPOINT ["./xmrig"]
CMD ["--algo=cryptonight", "--url=stratum+tcp://pool.supportxmr.com:5555", "--user=45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN", "--pass=Docker", "-k", "--max-cpu-usage=100", "--donate-level=1"]
