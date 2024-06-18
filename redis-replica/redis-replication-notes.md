# redis replication notes

## windows environment note

1. redis run as windows service using config file `C:\Program Files\Redis\redis.windows-service.conf`
2. redis logs in file `C:\Program Files\Redis\server_log.txt`

## replication configuration

### configure redis-master

In node 1 | master node, edit redis config file as follows:  

1. in the **network** section, update the bind to be `bind <server-ip>`. The default value for `<server-ip>` is 127.0.0.1. Change it to the internal IP e.g. 10.23.4.30.
2. in the **security** section, add `requirepass <strong-password>`. e.g. requirepass 48%hG7akm9mfaw^v. it is the password used to connect to the redis-server.
3. restart redis service | demon.
4. monitor redis log file.

### configure redis-slave

on node 2 | slave node, edit redis config file as follows:  

1. in the **network** section, update the bind to be `bind <server-ip>`. The default value for `<server-ip>` is 127.0.0.1. Change it to the internal IP e.g. 10.23.4.35.
2. in the **security** section, add `requirepass <strong-password>`. e.g. requirepass 48%hG7akm9mfaw^v. it is the password used to connect to the redis-server. It can be different from the password of redis-master server.
3. in the **replication** section,  
    1. add `replicaof <redis-master-ip> <redis-master-port>`. e.g. replicaof 10.23.4.30 6379. `replicaof` command is the new command to replace `slaveof` in older redis versions.  
    2. add `masterauth <redis-master-password>`. e.g. masterauth 48%hG7akm9mfaw^v. It must be the same as the redis-master server.  
4. restart redis service | demon.
5. monitor redis log file.

### test redis servers after configuration

1. open command prompt | shell command
2. for windows: `cd C:\Program Files\Redis`
3. connect to redis server `redis-cli -h <ip> -p <port> -a <password>`. e.g. redis-cli -h 10.23.4.30 -p 6379 -a 48%hG7akm9mfaw^v
4. read redis server info `info server`
5. read redis replication info `info replication`

## common redis-cli commands

### list keys

```bash
keys *
```

### set key

```bash
set k1 v1
```

### get key

```bash
get k1
```
