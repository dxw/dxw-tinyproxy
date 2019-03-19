# dxw docker container for tinyproxy

Our clients sometimes want an egress proxy to control where outgoing http
connections are going.
This container will be run as a daemon service in ECS and will allow the filter
list to be configured from parameter store.
