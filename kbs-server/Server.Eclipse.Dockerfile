#
# Dockerfile of KBS-Server-Eclipse
#
FROM phusion/baseimage:18.04-1.0.0


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


### Setup Zulu Openjdk (apt-get mode)
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
RUN apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'
RUN apt-get update
RUN EBIAN_FRONTEND=noninteractive apt-get install -y zulu-11

### Setup Zulu Openjdk (online mode)
# ENV JVM_DIR /usr/lib/jvm
# ENV ZULUOPENJDK_FILE zulu11.37.17-ca-jdk11.0.6-linux_x64
# RUN mkdir ${JVM_DIR}
# RUN wget https://cdn.azul.com/zulu/bin/${ZULUOPENJDK_FILE}.tar.gz \
# 	&& tar xfvz ${ZULUOPENJDK_FILE}.tar.gz --directory ${JVM_DIR} \
# 	&& rm ${ZULUOPENJDK_FILE}.tar.gz
# ENV JAVA_HOME ${JVM_DIR}/${ZULUOPENJDK_FILE}
# ENV PATH $PATH:$JAVA_HOME/bin

### Setup Zulu Openjdk (offline mode)
# ENV JVM_DIR /usr/lib/jvm
# ENV ZULUOPENJDK_FILE zulu11.37.17-ca-jdk11.0.6-linux_x64
# RUN mkdir ${JVM_DIR}
# RUN tar xfvz /tmp/app/${ZULUOPENJDK_FILE}.tar.gz --directory ${JVM_DIR} 
# ENV JAVA_HOME ${JVM_DIR}/${ZULUOPENJDK_FILE}
# ENV PATH $PATH:$JAVA_HOME/bin

### Java version
RUN java -version

### Add app stuff into Container
COPY app /tmp/app


### Setup IDEMPIERE_HOME (online mode)
# ENV IDEMPIERE_HOME /opt/idempiere-server/
# ENV IDEMPIERE_FILE kbs-server-7.1.0.latest-linux.gtk.x86_64.zip
# RUN wget https://github.com/kylinsystems/kbs-idempiere/releases/download/7.1.0.latest/${IDEMPIERE_FILE} \
# 	&& unzip -d /opt ${IDEMPIERE_FILE} && rm ${IDEMPIERE_FILE}

### Setup IDEMPIERE_HOME (offline mode)
ENV IDEMPIERE_HOME /opt/idempiere-server/
ENV IDEMPIERE_FILE kbs-server-7.1.0.latest-linux.gtk.x86_64.zip
RUN unzip -d /opt /tmp/app/${IDEMPIERE_FILE}
RUN rm /tmp/app/${IDEMPIERE_FILE}

WORKDIR $IDEMPIERE_HOME

### Setup Environment for idempiere-server
## Root Home
RUN mv /tmp/app/home.properties ${IDEMPIERE_HOME}/home.properties
RUN mv /tmp/app/eclipse/kbs-server.sh ${IDEMPIERE_HOME}/kbs-server.sh
# RUN mv /tmp/app/idempiere.properties ${IDEMPIERE_HOME}/idempiere.properties
# RUN mv /tmp/app/hazelcast.xml ${IDEMPIERE_HOME}/hazelcast.xml

## Jetty Home
# RUN mv /tmp/app/eclipse/jetty.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty.xml
# RUN mv /tmp/app/eclipse/jetty-alpn.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-alpn.xml
# RUN mv /tmp/app/eclipse/jetty-deployer.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-deployer.xml
# RUN mv /tmp/app/eclipse/jetty-http.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-http.xml
# RUN mv /tmp/app/eclipse/jetty-http2.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-http2.xml
# RUN mv /tmp/app/eclipse/jetty-https.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-https.xml
# RUN mv /tmp/app/eclipse/jetty-plus.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-plus.xml
# RUN mv /tmp/app/eclipse/jetty-selector.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-selector.xml
# RUN mv /tmp/app/eclipse/jetty-ssl.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-ssl.xml
# RUN mv /tmp/app/eclipse/jetty-ssl-context.xml ${IDEMPIERE_HOME}/jettyhome/etc/jetty-ssl-context.xml
# RUN mv /tmp/app/eclipse/webdefault.xml ${IDEMPIERE_HOME}/jettyhome/etc/webdefault.xml
# RUN mv /tmp/app/kbs-demo-keystore ${IDEMPIERE_HOME}/jettyhome/etc/kbs-demo-keystore

## Default CoaFile
RUN mv /tmp/app/AccountingDefaultsOnly.csv ${IDEMPIERE_HOME}/data/import/AccountingDefaultsOnly.csv

### Docker Entrypoint
RUN mv /tmp/app/docker-entrypoint.sh $IDEMPIERE_HOME

### Clean tmp/app
RUN rm -rf /tmp/app
### Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### set +x for script
RUN chmod 755 ${IDEMPIERE_HOME}/idempiere
RUN chmod 755 ${IDEMPIERE_HOME}/*.sh
RUN chmod 755 ${IDEMPIERE_HOME}/utils/*.sh
RUN chmod 755 ${IDEMPIERE_HOME}/utils/postgresql/*.sh

EXPOSE 8080 8443 4554

### Health Check
HEALTHCHECK --interval=5s --timeout=3s --retries=12 CMD curl --silent -fs http://localhost:8080/app || exit 1

### Add daemon to be run by runit
# RUN chmod +x ${IDEMPIERE_HOME}/kbs-server.sh
# RUN mkdir /etc/service/kbs-server
# RUN ln -s ${IDEMPIERE_HOME}/kbs-server.sh /etc/service/kbs-server/run

### Use baseimage-docker's init system
# CMD ["/sbin/my_init"]

RUN chmod +x ${IDEMPIERE_HOME}/kbs-server.sh
RUN ln -s $IDEMPIERE_HOME/kbs-server.sh /usr/bin/kbs-server

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["kbs-server"]
