FROM    alpine:edge

RUN     apk -U add \
            ca-certificates \
            curl \
            e2fsprogs \
            iptables \
            lxc

ENV     VERSION 1.8.1
ENV     SWARM_VERSION latest

#        procps \

RUN     curl -L -o /usr/local/bin/docker https://get.docker.com/builds/Linux/x86_64/docker-${VERSION} \
        && chmod +x /usr/local/bin/docker

RUN     curl -L -o /dind https://raw.githubusercontent.com/docker/docker/master/hack/dind \
        && chmod +x /dind

COPY    start.sh /opt/start.sh

VOLUME /var/lib/docker

ENTRYPOINT ["sh", "/opt/start.sh"]
