#
# Dockerfile of KBS-Server-Karaf
#
#
FROM phusion/baseimage:0.11
# FROM ubuntu:bionic-20200219
# FROM debian:stable-20200224-slim

### Make default locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

### Setup fast apt in China
RUN echo "deb https://mirrors.163.com/ubuntu/ bionic main restricted universe multiverse \n" \
		"deb https://mirrors.163.com/ubuntu/ bionic-security main restricted universe multiverse \n" \
	    "deb https://mirrors.163.com/ubuntu/ bionic-updates main restricted universe multiverse \n" \
		"deb https://mirrors.163.com/ubuntu/ bionic-proposed main restricted universe multiverse \n" \
        "deb https://mirrors.163.com/ubuntu/ bionic-backports main restricted universe multiverse \n" > /etc/apt/sources.list

### Setup Karaf Version
ENV KARAF_VERSION 4.2.8

### Make default timezone
RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Asia' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Asia select Shanghai' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends tzdata 

# Install unzip and other useful packages
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip pwgen expect sudo libfontconfig tzdata

# ### Make default timezone
# RUN echo "Asia/Shanghai" > /etc/timezone
# RUN dpkg-reconfigure -f noninteractive tzdata

### Setup IDEMPIERE_HOME
RUN mkdir /opt/idempiere-app;
ENV IDEMPIERE_HOME /opt/idempiere-app/
ENV KARAF_HOME ${IDEMPIERE_HOME}

# Add app stuff into Container
COPY app /tmp/app

# ### Install Apache Karaf (online model)
# RUN wget http://archive.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz -O /tmp/karaf.tar.gz
# RUN tar --strip-components=1 -C ${KARAF_HOME} -xzvf /tmp/karaf.tar.gz
# RUN rm /tmp/karaf.tar.gz

### Install Apache Karaf (offline model)
ENV KARAF_FILE /tmp/app/karaf/apache-karaf-${KARAF_VERSION}.tar.gz
RUN tar --strip-components=1 -C ${KARAF_HOME} -xzvf ${KARAF_FILE}
RUN rm ${KARAF_FILE}

# Setup Zulu Openjdk (offline mode)
ENV JVM_DIR /usr/lib/jvm
ENV ZULUOPENJDK_FILE zulu11.37.17-ca-jdk11.0.6-linux_x64
RUN mkdir ${JVM_DIR}
RUN tar xfvz /tmp/app/${ZULUOPENJDK_FILE}.tar.gz --directory ${JVM_DIR} 
ENV JAVA_HOME ${JVM_DIR}/${ZULUOPENJDK_FILE}
ENV PATH $PATH:$JAVA_HOME/bin

# Java version
RUN java -version


# Setup IDEMPIERE_HOME
ENV IDEMPIERE_FILE /tmp/app/kbs-server-7.1.0.latest-linux.gtk.x86_64.zip
ENV IDEMPIERE_REPOSITORY_FILE /tmp/app/karaf/kbs.karaf.repository.zip
### Unzip idempiere-server package, only folder plugins/* will be needed for karaf
RUN unzip -d ${IDEMPIERE_HOME}/ ${IDEMPIERE_FILE}
RUN rm ${IDEMPIERE_FILE}
### Unzip idempiere-repository package, this folder will be added as defaultRepositories for karaf
RUN unzip -d ${IDEMPIERE_HOME} ${IDEMPIERE_REPOSITORY_FILE}
RUN rm ${IDEMPIERE_REPOSITORY_FILE}


# Setup Environment for idempiere-server
### Root Home : add default idempiere-app properties files
RUN mv /tmp/app/idempiere.properties ${IDEMPIERE_HOME};
RUN mv /tmp/app/home.properties ${IDEMPIERE_HOME};
RUN mv /tmp/app/hazelcast.xml ${IDEMPIERE_HOME};
### Karaf Home : setup and configure Karaf to support rebranding, SSL + http2, offline model, Equinox Support, features of idempiere-app
RUN mv /tmp/app/karaf/etc/branding.properties ${KARAF_HOME}/etc;
RUN mv /tmp/app/karaf/etc/custom.properties ${KARAF_HOME}/etc;
# RUN mv /tmp/app/karaf/etc/karaf_maven_settings.xml ${KARAF_HOME}/etc;
RUN mv /tmp/app/karaf/etc/org.ops4j.pax.url.mvn.cfg ${KARAF_HOME}/etc;
RUN mv /tmp/app/karaf/etc/org.ops4j.pax.web.cfg ${KARAF_HOME}/etc;
RUN mv /tmp/app/karaf/etc/org.apache.karaf.features.cfg ${KARAF_HOME}/etc;
RUN mv /tmp/app/karaf/etc/jetty.xml ${KARAF_HOME}/etc;
### Setup Karaf Env
RUN mv /tmp/app/karaf/setenv ${KARAF_HOME}/bin;
### Add SSL Keystore
RUN mv /tmp/app/kbs-demo-keystore ${KARAF_HOME}/etc;

### Add AccoutingDefaultsOnly
RUN mkdir ${IDEMPIERE_HOME}/data/import/;
RUN mv /tmp/app/AccountingDefaultsOnly.csv ${IDEMPIERE_HOME}/data/import;
### Add utils folder
RUN mv /tmp/app/utils ${IDEMPIERE_HOME}/

### Clean TMP_APP
RUN rm -rf /tmp/app
### Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


### Open default port
# Default RMI Registry Port:1099
# Default RMI Server Port:44444
# Default http Port:8181
# Default https Port:8443
# Default SSH Port:8101
# Default Karaf Debug Port:5005
EXPOSE 8181 8443 5005

### Enabling SSH
# RUN rm -f /etc/service/sshd/down
### Enabling the insecure key permanently. In production environments, you should use your own keys.
# RUN /usr/sbin/enable_insecure_key

### Add daemon to be run by runit.
#RUN chmod +x ${KARAF_HOME}/bin/karaf
# RUN mkdir /etc/service/idempiere-app-karaf-server
# RUN ln -s ${KARAF_HOME}/bin/karaf /etc/service/idempiere-app-karaf-server/run

### Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]

### KARAF_OPTS and Bin PATH
#ENV KARAF_OPTS "-Djava.net.preferIPv4Stack=true"
#ENV KARAF_OPTS -javaagent:/$KARAF_HOME/jolokia-agent.jar=host=0.0.0.0,port=8778,authMode=jaas,realm=karaf,user=admin,password=admin,agentId=$HOSTNAME
ENV PATH $PATH:${KARAF_HOME}/bin
CMD ["/opt/idempiere-app/bin/karaf", "run"]