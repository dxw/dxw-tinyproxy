#!/bin/bash
set -e

echo "ENTRYPOINT: Starting docker entrypoint…"
env 
if  [[ -z $TINYPROXY_CONFIG ]]
then
  echo "using default config"
  cp /etc/default.tinyproxy.conf /etc/tinyproxy.conf
else
  echo "setting config"
  echo -e "$TINYPROXY_CONFIG" > /etc/tinyproxy.conf
fi

if [[ -z $TINYPROXY_FILTER_LIST ]]
then
  echo "not creating a filter list"
else
  echo "creating a filter list"
  echo -e "$TINYPROXY_FILTER_LIST" > /etc/tinyproxy_filter
fi

echo "ENTRYPOINT: Finished docker entrypoint."
exec "$@"
