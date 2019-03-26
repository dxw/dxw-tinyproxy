FROM ubuntu:cosmic

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
    tinyproxy \
    wget \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

COPY ./default.tinyproxy.conf /etc/
COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8888
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["tinyproxy", "-d", "-c", "/etc/tinyproxy.conf"]
