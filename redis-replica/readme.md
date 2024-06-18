# sample redis replication

## description

this docker compose file creates two containers from redis nodes. one of them is master and the other is slave.

## run the containers

```shell
docker-compose up
```

to run as daemon

```shell
docker-compose up -d
```

## run commands in the redis-master container shell

from the host

```shell
docker exec -it redis-master /bin/bash
```
