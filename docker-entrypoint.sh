#!/bin/sh
set -e

isCommand() {
  if [ "$1" = "sh" ]; then
    return 1
  fi

  expose help --no-interaction "$1" > /dev/null 2>&1
}

# check if the first argument passed in looks like a flag or command
if [ "${1#-}" != "$1" ] || isCommand "$1"; then
  set -- expose "$@"
fi

## check if the first argument passed in is expose and if it's the only one
if [ "$#" = 1 ] && [ "$1" = "expose" ]; then
  if [ -n "${SUBDOMAIN}" ]; then
    set -- "$@" "--subdomain=${SUBDOMAIN}"
  fi
  if [ -n "${AUTH_TOKEN}" ]; then
    set -- "$@" "--auth=${AUTH_TOKEN}"
  fi

  if [ -n "${BASIC_AUTH}" ]; then
    set -- "$@" "--basicAuth=${BASIC_AUTH}"
  fi

  if [ -n "${DNS_SERVER}" ]; then
    set -- "$@" "--dns=${DNS_SERVER}"
  fi

  if [ -n "${DOMAIN}" ]; then
    set -- "$@" "--domain=${DOMAIN}"
  fi

  if [ -n "${SERVER}" ]; then
    set -- "$@" "--server=${SERVER}"
  fi

  if [ -n "${SERVER_HOST}" ]; then
    set -- "$@" "--server-host=${SERVER_HOST}"
  fi

  if [ -n "${SERVER_PORT}" ]; then
    set -- "$@" "--server-port=${SERVER_PORT}"
  fi
fi

set -- tini -- "$@"

exec "$@"
