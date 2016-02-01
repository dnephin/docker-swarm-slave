FROM    alpine:3.3

RUN     apk -U add \
            bash \
            ca-certificates \
            curl \
            e2fsprogs \
            iptables \
            lxc \
            procps \
            s6 \
            xz

ENV     VERSION=1.10.1
RUN     curl -L -o /usr/local/bin/docker \
            https://get.docker.com/builds/Linux/x86_64/docker-${VERSION} \
        && chmod +x /usr/local/bin/docker

RUN     curl -L -o /dind \
            https://raw.githubusercontent.com/docker/docker/master/hack/dind \
        && chmod +x /dind

COPY    srv /srv
COPY    wait_on_daemon /wait_on_daemon
COPY    wait_on_discovery /wait_on_discovery

ENV     SWARM_VERSION=latest
ENV     DOCKER_PORT=2375

VOLUME  /var/lib/docker
ENTRYPOINT ["s6-svscan", "/srv"]
