# expose-docker

Exposes [beyondcode/expose](https://expose.dev/) via docker

## Usage

```bash
docker run backdevs/expose <expose command>
```

For example, `docker run backdevs/expose share http://localhost`.

### Docker compose

```yaml
services:
  # Other services
 
  expose:
    image: backdevs/expose
    args:
      PHP_VERSION: 8.2.8
      VERSION: 2.6.2
    environment:
      AUTH_TOKEN: 'your-expose-dot-dev-token'
    ports:
      - 4040:4040
```

Now you can run commans like `docker compose run expose share http://localhost`.

### Arguments

Argument            | Default value
--------------------|-----------------
PHP_VERSION         | 8.2.8
VERSION             | 2.6.2

### Environment variables

Variable            | Default value
--------------------|-----------------
AUTH_TOKEN          | *None*
BASIC_AUTH          | *None*
DOMAIN              | *None*
DNS_SERVER          | `TRUE`
MEMORY_LIMIT        | 128M
SERVER              | *None*
SERVER_HOST         | sharedwithexpose.com
SERVER_PORT         | 443
SERVERS_ENDPOINT    | https://expose.dev/api/servers
SHARE               | *None*
SUBDOMAIN           | expose
