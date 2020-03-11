REM ######################################################
REM Setup KBS Docker Suite Dev
REM ######################################################
REM ......................................................
call env.bat

call kbs-cleanup.bat

REM ######################################################
REM Creating data volume...
REM ######################################################
docker volume create --name=kbs_portainer_data
docker volume create --name=kbs_pgmaster
docker volume create --name=kbs_pgslave1
docker volume create --name=kbs_pgslave3
docker volume create --name=kbs_pgbackup

REM ######################################################
REM Creating separate docker network...
REM ######################################################
docker network create -d bridge kbs_core
docker network create -d bridge kbs_pgcluster

REM ######################################################
REM Building images...
REM ######################################################
docker-compose -f kbs-portainer/docker-compose.yml build
docker-compose -f kbs-pgcluster/docker-compose.yml build
docker-compose -f kbs-pgseed/docker-compose.yml build
docker-compose -f kbs-pgmigrator/docker-compose.yml build
docker-compose -f kbs-pgweb/docker-compose.yml build
docker-compose -f kbs-pgadmin4/docker-compose.yml build
docker-compose -f kbs-server/docker-compose.yml build

REM ######################################################
REM Starting...
REM ######################################################
docker-compose -f kbs-portainer/docker-compose.yml up --force-recreate -d

docker-compose -f kbs-pgcluster/docker-compose.yml up --force-recreate -d pgmaster pgslave1 pgslave3 pgbackup pgpool
ping -n 60 127.1 >nul

docker-compose -f kbs-pgseed/docker-compose.yml up --force-recreate

docker-compose -f kbs-pgmigrator/docker-compose.yml up --force-recreate

docker-compose -f kbs-pgweb/docker-compose.yml up --force-recreate -d

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
REM Dev Setup finished!
REM ######################################################