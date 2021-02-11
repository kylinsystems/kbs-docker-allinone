#
# Dockerfile of KBS-Server-Eclipse (Pro)
#
FROM phusion/baseimage:18.04-1.0.0

ENV KBS_VERSION 202102110949

### Make default locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale


### Install unzip and other useful packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nano wget unzip pwgen expect sudo libfontconfig postgresql-client

### Setup Zulu Openjdk (apt-get mode)
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
RUN apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y zulu-11
ENV JAVA_HOME=/usr/lib/jvm/zulu-11-amd64

### Java version
RUN java -version

### Timezone
RUN echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean


### Add app stuff into Container
COPY app /tmp/app

### Setup IDEMPIERE_HOME
ARG KBS_TAG
ENV IDEMPIERE_HOME /opt/idempiere-server
ENV IDEMPIERE_FILE kbs-server-${KBS_TAG}-linux.gtk.x86_64.zip
WORKDIR $IDEMPIERE_HOME

## Setup IDEMPIERE Package (online mode)
RUN wget https://github.com/kylinsystems/kbs-idempiere/releases/download/${KBS_TAG}/${IDEMPIERE_FILE} \
	&& unzip -d /opt ${IDEMPIERE_FILE} && rm ${IDEMPIERE_FILE}

### Setup Environment for idempiere-server
## Root Home
RUN mv /tmp/app/home.properties ${IDEMPIERE_HOME}/home.properties
RUN mv /tmp/app/eclipse/kbs-server.sh ${IDEMPIERE_HOME}/kbs-server.sh
RUN mv /tmp/app/data/lang ${IDEMPIERE_HOME}/data/
## Docker Entrypoint
RUN mv /tmp/app/docker-entrypoint.sh $IDEMPIERE_HOME

### Clean up
## Clean tmp/app
RUN rm -rf /tmp/app
## Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### set +x for script
RUN chmod 755 ${IDEMPIERE_HOME}/idempiere
RUN chmod 755 ${IDEMPIERE_HOME}/*.sh
RUN chmod 755 ${IDEMPIERE_HOME}/utils/*.sh
RUN chmod 755 ${IDEMPIERE_HOME}/utils/postgresql/*.sh
RUN chmod 755 ${IDEMPIERE_HOME}/data/lang/*.sh

### Export Port
EXPOSE 8080 8443 4554


### Setup script for Entrypoint
RUN chmod +x ${IDEMPIERE_HOME}/kbs-server.sh
RUN ln -s $IDEMPIERE_HOME/kbs-server.sh /usr/bin/kbs-server

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["kbs-server"]
