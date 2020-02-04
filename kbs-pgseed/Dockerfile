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
		apt-get install -y postgresql-$PG_MAJOR postgresql-contrib-$PG_MAJOR && \
		/etc/init.d/postgresql stop

### Configure the database
RUN sed -i -e"s/data_directory =.*$/data_directory = '\/data'/" /etc/postgresql/$PG_MAJOR/main/postgresql.conf
### Allow connections from anywhere.
RUN sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/$PG_MAJOR/main/postgresql.conf
RUN echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/$PG_MAJOR/main/pg_hba.conf

### Install other tools.
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y pwgen inotify-tools

### Copy and setup iDempiere Database Package
RUN mkdir /opt/idempiere-app/
COPY db /opt/idempiere-app/db
ENV IDEMPIERE_DB_HOME /opt/idempiere-app/db
ENV IDEMPIERE_HOME ${IDEMPIERE_DB_HOME}
RUN mv ${IDEMPIERE_DB_HOME}/myEnvironment.sh ${IDEMPIERE_HOME}/utils;
RUN chmod 755 ${IDEMPIERE_DB_HOME}/utils/*.sh;

### Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### Copy scripts
COPY scripts /scripts
RUN chmod +x /scripts/start.sh
RUN touch /firstrun

### Add daemon to be run by runit.
RUN mkdir /etc/service/postgresql
RUN ln -s /scripts/start.sh /etc/service/postgresql/run

### Correct the Error: could not open temporary statistics file "/var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp/global.tmp": No such file or directory
RUN mkdir -p /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp
RUN chown postgres.postgres /var/run/postgresql/$PG_MAJOR-main.pg_stat_tmp -R

EXPOSE 5432

# Health Check
# HEALTHCHECK --interval=10s --timeout=3s --retries=6 CMD pg_isready -U postgres

### Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
