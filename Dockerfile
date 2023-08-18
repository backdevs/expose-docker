ARG PHP_VERSION=8.2.8
FROM php:${PHP_VERSION}-cli-alpine

ARG VERSION=2.6.2
ENV VERSION=${VERSION}

ENV SERVER_HOST='sharedwithexpose.com'

ENV SERVER_PORT=443

ENV SERVERS_ENDPOINT='https://expose.dev/api/servers'

ENV DNS_SERVER=true

ENV AUTH_TOKEN=''

ENV MEMORY_LIMIT='128M'

ENV SUBDOMAIN='expose'

COPY config.php /root/.expose/config.php
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN apk add --no-cache --virtual .runtime-deps  \
      tini \
    && curl https://github.com/beyondcode/expose/raw/${VERSION}/builds/expose -L --output /usr/local/bin/expose \
    && chmod +x /usr/local/bin/expose

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["expose"]

EXPOSE 4040
