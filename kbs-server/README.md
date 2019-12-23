# KBS Docker : Server 
Running KBS Server in Docker

## Prerequisites
Download kbs-server-7.1.0.latest-linux.gtk.x86_64.zip from https://github.com/kylinsystems/kbs-idempiere/releases/tag/7.1.0.latest

Place it into folder kbs-server/app

## Build & install
Please refer to https://github.com/kylinsystems/kbs-docker-allinone

## Usage
### SSH to container:

	# Download the insecure private key
	curl -o insecure_key -fSL https://github.com/phusion/baseimage-docker/raw/master/image/services/sshd/keys/insecure_key
	chmod 600 insecure_key

	# Login to the container
	ssh -i insecure_key root@$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" kbs-server)

	# sftp back to docker host for download & upload purpose:
	sftp user@docker-host-ip

### Shell to container:

	# For debugging and maintenance purposes you may want access the containers shell.
	docker exec -it kbs-server bash