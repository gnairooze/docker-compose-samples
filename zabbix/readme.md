# sample zabbix servers

## description

this docker compose file creates a 3 containers to run zabbix monitoring solution. postgres server, zabbix server and zabbix web interface.

## run the containers

```shell
docker-compose up
```

to run as daemon

```shell
docker-compose up -d
```

## connect to the server from the host

to connect to it from the host using sql server management studio

**server name:** `127.0.0.1`
**server port:** `5432`
**login:** `zabbix`  
**password:** `zabbix_password`  
