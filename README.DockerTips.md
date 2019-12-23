# Docker Tips

## Docker 常用命令
```
# Remove all unused networks
docker network prune

# Remove all stopped containers
docker container prune 

# Remove all unused volumes 
docker volume prune 

# Remove unused images 
docker image prune 

# All of the above, in this order: containers, volumes, images
docker system prune 
```
```
# Docker shell
docker exec -it [CONTAINER ID OR NAME] /bin/sh

# Docker attach 进入Container查看输出
docker attach [CONTAINER ID OR NAME]
```
```
# Export docker logs
docker logs -f [CONTAINER ID OR NAME] > log.txt
```
```
# Copy file between container and docker host
## 从主机复制到容器
sudo docker cp host_path containerID:container_path
## 从容器复制到主机
sudo docker cp containerID:container_path host_path
## For example:
docker cp kbs-server:/opt/data/ExpDat.jar c:\data\
```
```
# For Linux or by Windows PowerShell
-- stop all containers
docker stop $(docker ps -a -q)
-- remove all stopped containers
docker rm $(docker ps -a -q)
-- remove all services
docker service rm $(docker service ls -q)
-- remove all images
docker rmi $(docker images -q)

# For Windows DOS Cmd
-- stop all containers
FOR /f "tokens=*" %i IN ('docker ps -a -q') DO docker stop %i
-- remove all containers
FOR /f "tokens=*" %i IN ('docker ps -a -q') DO docker rm %i
-- remove all services
FOR /f "tokens=*" %i IN ('docker service ls -q') DO docker service rm %i   
-- remove all images
FOR /f "tokens=*" %i IN ('docker images -q -f "dangling=true"') DO docker rmi %i
```
```
# Login with your Docker ID to push and pull images from Docker Hub
https://hub.docker.com/u/kylinsystems
docker login
Username: longnan
Password:
docker push id/imagename:tagname
# 6.2.0.latest
docker push kylinsystems/kbs-haproxy:6.2.0.latest
docker push kylinsystems/kbs-pgsingle:6.2.0.latest
docker push kylinsystems/kbs-pgseed:6.2.0.latest
docker push kylinsystems/kbs-pgmigrator:6.2.0.latest
docker push kylinsystems/kbs-pgbackupper:6.2.0.latest
docker push kylinsystems/kbs-pgweb:6.2.0.latest
docker push kylinsystems/kbs-server-eclipse:6.2.0.latest
```

## Image Creation

This example creates the image with the tag `kylinsystems/kbs-docker-x`, but you can
change this to use your own username.

```
$ docker build --rm --force-rm -t="kylinsystems/kbs-docker-x:1.0.0" .
```

## Image Save/Load
```
# save image to tarball
$ docker save kylinsystems/kbs-docker-x:1.0.0 | gzip > kylinsystems/kbs-docker-x-1.0.0.tar.gz

# load it back
$ gzcatkylinsystems/kbs-docker-x-1.0.0.tar.gz | docker load
```

## Container Creation / Running
```
$ docker run -d -t --name="kbs-docker-x" kylinsystems/kbs-docker-x:1.0.0
$ docker logs -f kbs-docker-x
```

## KBS Monitoring
docker stack deploy -c kbs-monitoring/docker-compose.yml prom

docker-compose -f kbs-monitoring/docker-compose.yml build
docker-compose -f kbs-monitoring/docker-compose.yml up --force-recreate -d

## KSYS Logging
    Graylog web
    http://localhost:9000
    admin/admin

    1. Disable Anonymous usage statistics
    2. Setup input : GELF UDP


## KSYS OpenLdap
    Login DN: cn=admin,dc=example,dc=org
    Password: admin

    <!-- web2ldap
    http://localhost:1760/web2ldap/ -->

## KSYS Prometheus
    The Grafana Dashboard:
    http://localhost:3000
    admin/Grafana

    The Prometheus web:
    http://localhost:9090

    The Alertmanager web:
    http://localhost:9093

    The target metrics of Prometheus:
    Prometheus:    http://localhost:9090/metrics
    Docker Daemon: http://localhost:9323/metrics
    Alertmanager:  http://localhost:9093/metrics



## Grafana Dashboard
    https://grafana.com/dashboards/193
    https://grafana.com/dashboards/179
    https://grafana.com/dashboards/1229
    https://grafana.com/dashboards/22
    ----------------------------------------------
    https://grafana.com/dashboards/609
    https://github.com/bvis/docker-prometheus-swarm
    ----------------------------------------------
    https://grafana.com/dashboards/395
    https://github.com/uschtwill/docker_monitoring_logging_alerting
    ----------------------------------------------

## Install KBS feature in Karaf manually:
```
karaf@root()> feature:repo-add mvn:com.kylinsystems.kbs.karaf/com.kylinsystems.kbs.karaf.feature/5.1.0.v2018/xml/features
    
karaf@root()> feature:install -v com.kylinsystems.kbs.karaf.base
karaf@root()> feature:install -v com.kylinsystems.kbs.karaf.app
	
	or
	
karaf@root()> feature:install -v com.kylinsystems.kbs.karaf.all
```


