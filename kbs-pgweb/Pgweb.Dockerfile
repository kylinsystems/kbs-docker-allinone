#
# KBS Dockerfile of PGWeb
#
# pgweb, a web-based PostgreSQL database browser. https://github.com/sosedoff/pgweb
#

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

### Install Tools
RUN apt-get update && \
		DEBIAN_FRONTEND=noninteractive \
		apt-get install -y unzip

### Install PGWeb
ENV LISTEN_PORT 80
ENV PG_HOST_NAME pghost
ENV PG_HOST_PORT 5432
ENV PG_PASSWORD default_pass
ENV PG_USER default_user
ENV PG_DB default_db
ENV PGWEB_AUTH_USER pgweb
ENV PGWEB_AUTH_PASS pgweb

COPY ./pgweb /tmp/pgweb

RUN \
  cd /tmp/pgweb && \
  unzip /tmp/pgweb/pgweb_linux_amd64.zip -d /app

RUN mv /tmp/pgweb/start-pgweb.sh /app
RUN chmod +x /app/start-pgweb.sh

### Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080

### Usage 1 : by pgweb CLI options
### Add user pgweb
#RUN useradd -ms /bin/bash pgweb
#USER pgweb
#WORKDIR /app
#ENTRYPOINT ["/app/pgweb_linux_amd64"]
#CMD ["-s", "--bind=0.0.0.0", "--listen=8080", "--readonly", "--lock-session", "--url=postgres://adempiere:adempiere@idempiere-db:5432/idempiere?sslmode=disable", "--auth-user=pgweb", "--auth-pass=pgweb"]

### Usage 2 : Add daemon to be run by runit.
RUN mkdir /etc/service/startpgweb
RUN ln -s /app/start-pgweb.sh /etc/service/startpgweb/run
### Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
