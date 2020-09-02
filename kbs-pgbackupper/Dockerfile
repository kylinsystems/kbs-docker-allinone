FROM postgres:11.9

# Add debian mirror in China for faster accessing
RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib \n" \
		"deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib \n" \
	    "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib \n" \
		"deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib \n" > /etc/apt/sources.list


RUN apt-get update -y && \
    apt-get install -y cron php-cli && \
    apt-get clean -y && \
    mkdir /var/log/backupper/

### Timezone
RUN echo $TZ > /etc/timezone
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean


ENV ENV_FILE "/env.sh"
RUN touch $ENV_FILE && chmod +x $ENV_FILE

ADD bin /backupper_bin
RUN chmod +x /backupper_bin/*.sh
WORKDIR /backupper_bin
CMD /backupper_bin/entrypoint.sh