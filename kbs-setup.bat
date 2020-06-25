REM ######################################################
REM Setup KBS Docker Suite
REM ######################################################
REM ......................................................
call env.bat

REM ######################################################
REM Creating data volume...
REM ######################################################
docker volume create --name=kbs_portainer_data
docker volume create --name=kbs_pg_data
REM docker volume create --name=kbs_pgmaster
REM docker volume create --name=kbs_pgslave1
REM docker volume create --name=kbs_pgslave3
docker volume create --name=kbs_pgbackup

REM ######################################################
REM Creating separate docker network...
REM ######################################################
docker network create -d bridge kbs_core
REM docker network create -d bridge kbs_pgcluster

REM ######################################################
REM Building images...
REM ######################################################
docker-compose -f kbs-portainer/docker-compose.yml build
docker-compose -f kbs-pgsingle/docker-compose.yml build
REM docker-compose -f kbs-pgcluster/docker-compose.yml build
REM docker-compose -f kbs-pgweb/docker-compose.yml build
docker-compose -f kbs-pgadmin4/docker-compose.yml build
docker-compose -f kbs-server/docker-compose.yml build

REM ######################################################
REM Starting...
REM ######################################################
docker-compose -f kbs-portainer/docker-compose.yml up --force-recreate -d

REM docker-compose -f kbs-pgcluster/docker-compose.yml up --force-recreate -d
REM ping -n 60 127.1 >nul

docker-compose -f kbs-pgsingle/docker-compose.yml up --force-recreate -d

REM docker-compose -f kbs-pgweb/docker-compose.yml up --force-recreate -d

docker-compose -f kbs-pgadmin4/docker-compose.yml up --force-recreate -d

docker-compose -f kbs-server/docker-compose.yml up --force-recreate -d

REM ######################################################
REM List all
REM ######################################################
docker network ls
docker volume ls
docker ps

REM ......................................................
REM ######################################################
REM Setup finished!
REM ######################################################