# CPU miner for monero (cryptonight algorithm) uses [xmrig](https://github.com/xmrig/xmrig)

# Introducing: Monero
It is still possible to get into cryptocurrency with your regular hardware though, but you’ll have to mine different currencies.

The best one at the moment is probably: **Monero**

This cryptocurrency has been created to be easier on the CPU, harder on a GPU.

Do you want to start mining Monero coins too?
The easiest way is to fire up a Docker image like this:

```bash
$ docker run marcomsousa/monero-miner -a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -u 45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN -p docker
```

Run in a Docker Swarm Cluster all nodes

```bash
$ docker service create \
--name monero \
--mode global \
marcomsousa/monero-miner \
-a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -u 45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN -p docker
```

Run in a Docker Swarm Cluster with replicas

```bash
$ docker service create \
--name monero \
--replicas 5 \
marcomsousa/monero-miner \
-a cryptonight -o stratum+tcp://pool.supportxmr.com:5555 -u 45isfMEfmBY6jx7sYPiB9M7LnKU9uK5gqTv4UGbPJ8zm3bu4XEz3NwL4Ke9UnWQEmkEn7it9rbqQFfQv9do3C9Jg5rqozgN -p docker
```
