#!/bin/bash
set -e

if [[ -z $AWS_HOST ]]; then
  echo "setting a default host IP"
  HOST_IP="tinyproxy.stats"
else
  HOST_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4 2>/dev/null)
fi

echo "ENTRYPOINT: Starting docker entrypoint…"

if  [[ -z $TINYPROXY_CONFIG ]]
then
  echo "using default config"
  cp /etc/default.tinyproxy.conf /etc/tinyproxy.conf
  sed -i "s/TINYPROXY_STAT_HOST/$HOST_IP/g" /etc/tinyproxy.conf
else
  echo "setting config"
  echo -e "$TINYPROXY_CONFIG" > /etc/tinyproxy.conf
fi

if [[ -z $TINYPROXY_FILTER_LIST ]]
then
  echo "not creating a filter list"
  echo "$HOST_IP" > /etc/tinyproxy_filter
else
  echo "creating a filter list"
  echo -e "$TINYPROXY_FILTER_LIST" > /etc/tinyproxy_filter
  echo "$HOST_IP" >> /etc/tinyproxy_filter
fi


echo "ENTRYPOINT: Finished docker entrypoint."
exec "$@"
