FROM postgres:11.8

### Make default locale
RUN locale-gen en_US.UTF-8 && \
    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

# Add debian mirror in China for faster accessing
RUN echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib \n" \
		"deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib \n" \
	    "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib \n" \
		"deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib \n" > /etc/apt/sources.list


RUN apt-get update -y && \
    apt-get install -y cron php-cli && \
    apt-get clean -y && \
    mkdir /var/log/backupper/

ENV ENV_FILE "/env.sh"
RUN touch $ENV_FILE && chmod +x $ENV_FILE

ADD bin /backupper_bin
WORKDIR /backupper_bin
CMD /backupper_bin/entrypoint.sh