FROM phusion/baseimage:0.11

### Make default locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

### Setup fast apt in China
RUN echo "deb https://mirrors.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse \n" \
		"deb https://mirrors.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse \n" \
	    "deb https://mirrors.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse \n" \
		"deb https://mirrors.huaweicloud.com/ubuntu/ bionic-proposed main restricted universe multiverse \n" \
        "deb https://mirrors.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse \n" > /etc/apt/sources.list


LABEL Name HAProxy
LABEL Release Community Edition
LABEL Vendor HAProxy
LABEL Version 2.0.12
LABEL RUN /usr/bin/docker -d IMAGE

ENV HAPROXY_BRANCH 2.0
ENV HAPROXY_MINOR 2.0.12
ENV HAPROXY_SHA256 7fcf5adb21cd78c4161902f9fcc8d7fc97e1562319a992cbda884436ca9602fd
ENV HAPROXY_SRC_URL http://www.haproxy.org/download

ENV HAPROXY_UID haproxy
ENV HAPROXY_GID haproxy

# defaults (docker name server) for the variables used in haproxy.cfg
ENV DNS_TCP_ADDR 127.0.0.11
ENV DNS_TCP_PORT 53

COPY haproxy-$HAPROXY_MINOR.tar.gz /haproxy.tar.gz

RUN apt-get update && \
    apt-get install -y --no-install-recommends libssl1.0.0 zlib1g "libpcre2-*" liblua5.3-0 tar curl socat && \
    apt-get install -y --no-install-recommends gcc make libc6-dev libssl-dev libpcre3-dev zlib1g-dev liblua5.3-dev && \
    apt-get install -y --no-install-recommends inotify-tools && \
    # curl -sfSL "$HAPROXY_SRC_URL/$HAPROXY_BRANCH/src/haproxy-$HAPROXY_MINOR.tar.gz" -o haproxy.tar.gz && \
    echo "$HAPROXY_SHA256 *haproxy.tar.gz" | sha256sum -c - && \
    groupadd "$HAPROXY_GID" && \
    useradd -g "$HAPROXY_GID" "$HAPROXY_UID" && \
    mkdir -p /tmp/haproxy && \
    tar -xzf haproxy.tar.gz -C /tmp/haproxy --strip-components=1 && \
    rm -f haproxy.tar.gz && \
    make -C /tmp/haproxy -j"$(nproc)" TARGET=linux-glibc CPU=generic USE_PCRE2=1 USE_PCRE2_JIT=1 USE_REGPARM=1 USE_OPENSSL=1 \
                            USE_ZLIB=1 USE_TFO=1 USE_LINUX_TPROXY=1 USE_LUA=1 USE_GETADDRINFO=1 \
                            EXTRA_OBJS="contrib/prometheus-exporter/service-prometheus.o" \
                            all && \
    make -C /tmp/haproxy TARGET=linux-glibc install-bin install-man && \
    ln -s /usr/local/sbin/haproxy /usr/sbin/haproxy && \
    mkdir -p /var/lib/haproxy && \
    chown "$HAPROXY_UID:$HAPROXY_GID" /var/lib/haproxy && \
    mkdir -p /usr/local/etc/haproxy && \
    ln -s /usr/local/etc/haproxy /etc/haproxy && \
    cp -R /tmp/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors && \
    rm -rf /tmp/haproxy && \
    apt-get purge -y --auto-remove gcc make libc6-dev libssl-dev libpcre2-dev zlib1g-dev liblua5.3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY haproxy.cfg /usr/local/etc/haproxy
COPY docker-entrypoint.sh /

EXPOSE 80 443

STOPSIGNAL SIGUSR1

ENTRYPOINT ["/docker-entrypoint.sh"]

