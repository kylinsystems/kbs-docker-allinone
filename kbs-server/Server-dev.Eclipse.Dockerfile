#
# Dockerfile of KBS-Server-Eclipse (Dev)
#
FROM phusion/baseimage:18.04-1.0.0

ENV KBS_DOCKER_VERSION 202101252348

### Make default locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale


### Setup fast apt in China
RUN echo "deb https://mirrors.huaweicloud.com/ubuntu/ bionic main restricted universe multiverse \n" \
		"deb https://mirrors.huaweicloud.com/ubuntu/ bionic-security main restricted universe multiverse \n" \
	    "deb https://mirrors.huaweicloud.com/ubuntu/ bionic-updates main restricted universe multiverse \n" \
		"deb https://mirrors.huaweicloud.com/ubuntu/ bionic-proposed main restricted universe multiverse \n" \
        "deb https://mirrors.huaweicloud.com/ubuntu/ bionic-backports main restricted universe multiverse " > /etc/apt/sources.list


### Install unzip and other useful packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends nano wget unzip pwgen expect sudo libfontconfig postgresql-client

### Add app stuff into Container
COPY app /tmp/app

### Setup Zulu Openjdk (offline mode)
ENV JVM_DIR /usr/lib/jvm
ENV ZULUOPENJDK_FILE zulu11.41.23-ca-jdk11.0.8-linux_x64
RUN mkdir ${JVM_DIR}
RUN tar xfvz /tmp/app/${ZULUOPENJDK_FILE}.tar.gz --directory ${JVM_DIR} 
ENV JAVA_HOME ${JVM_DIR}/${ZULUOPENJDK_FILE}
ENV PATH $PATH:$JAVA_HOME/bin

### Java version
RUN java -version

### Timezone
RUN echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

### Setup IDEMPIERE_HOME
ARG KBS_TAG
ENV IDEMPIERE_HOME /opt/idempiere-server
ENV IDEMPIERE_FILE kbs-server-${KBS_TAG}-linux.gtk.x86_64.zip
WORKDIR $IDEMPIERE_HOME

## Setup IDEMPIERE Package (offline mode)
RUN unzip -d /opt /tmp/app/${IDEMPIERE_FILE}
RUN rm /tmp/app/${IDEMPIERE_FILE}

### Setup Environment for idempiere-server
## Root Home
RUN mv /tmp/app/home.properties ${IDEMPIERE_HOME}/home.properties
RUN mv /tmp/app/eclipse/kbs-server.sh ${IDEMPIERE_HOME}/kbs-server.sh
RUN mv /tmp/app/data/fonts ${IDEMPIERE_HOME}/data/
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

### Health Check
# HEALTHCHECK --interval=5s --timeout=3s --retries=12 CMD curl --silent -fs http://localhost:8080/app || exit 1


### Setup script for Entrypoint
RUN chmod +x ${IDEMPIERE_HOME}/kbs-server.sh
RUN ln -s $IDEMPIERE_HOME/kbs-server.sh /usr/bin/kbs-server

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["kbs-server"]
