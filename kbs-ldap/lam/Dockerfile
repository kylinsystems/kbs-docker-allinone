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

ADD start.sh /start.sh

ADD health.sh /health.sh
HEALTHCHECK --interval=60s --timeout=30s --start-period=600s --retries=3 CMD /health.sh

ENV CONFIG=/etc/ldap-account-manager
ENV DATA=/var/lib/ldap-account-manager

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install --no-install-recommends --no-install-suggests -y ldap-account-manager php-imap wget rsync \
 && phpenmod imap \
 && mv $CONFIG $CONFIG.original \
 && mv $DATA $DATA.original \
 && mkdir $DATA $CONFIG \
 && chown www-data.www-data $DATA $CONFIG \
 && sed -i 's,DocumentRoot .*,DocumentRoot /usr/share/ldap-account-manager,' /etc/apache2/sites-available/000-default.conf \
 && ln -sf /proc/1/fd/1 /var/log/apache2/access.log \
 && ln -sf /proc/1/fd/2 /var/log/apache2/error.log

EXPOSE 80
VOLUME $CONFIG
VOLUME $DATA

### Add daemon to be run by runit.
RUN mkdir /etc/service/lam
RUN ln -s /start.sh /etc/service/lam/run

### Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
