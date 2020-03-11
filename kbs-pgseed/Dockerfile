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

### Install PG from ubuntu default repository
ENV PG_MAJOR 10
RUN apt-get update && \
		DEBIAN_FRONTEND=noninteractive \
		apt-get install -y --force-yes postgresql-client-$PG_MAJOR

### Copy and setup Seed Database Util
RUN mkdir /opt/idempiere-app/
COPY db /opt/idempiere-app/db

ENV IDEMPIERE_DB_HOME /opt/idempiere-app/db

RUN chmod 755 ${IDEMPIERE_DB_HOME}/utils/*.sh;

### Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Copy scripts
COPY scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun

CMD ["/scripts/start.sh"]
