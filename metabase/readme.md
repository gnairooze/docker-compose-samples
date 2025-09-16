# metabase tips

## connect to sql server container

when you have a sql server container running, and expose port 14333 for example,

### From Linux

use the Docker bridge gateway IP (typically 172.17.0.1) to reach the host.

### From Windows or Mac

the host name is `host.docker.internal`, not `localhost` or `127.0.0.1`.
