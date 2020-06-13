REM ######################################################
REM Uninstalling KBS Docker Suite
REM ######################################################
REM ......................................................
call env.bat

REM ######################################################
REM Stopping and removing containers...
REM ######################################################
docker-compose -f kbs-server/docker-compose.yml down -v
docker-compose -f kbs-pgbackupper/docker-compose.yml down -v
docker-compose -f kbs-pgadmin4/docker-compose.yml down -v
docker-compose -f kbs-pgweb/docker-compose.yml down -v
docker-compose -f kbs-pgmigrator/docker-compose.yml down -v
docker-compose -f kbs-pgseed/docker-compose.yml down -v
docker-compose -f kbs-pgsingle/docker-compose.yml down -v
docker-compose -f kbs-pgcluster/docker-compose.yml down -v
docker-compose -f kbs-portainer/docker-compose.yml down -v

REM ###### Prune all stopped containers
docker container prune -f

REM ######################################################
REM Removing data volume...
REM ######################################################
docker volume rm kbs_portainer_data
docker volume rm kbs_pg_data
docker volume rm kbs_pgmaster
docker volume rm kbs_pgslave1
docker volume rm kbs_pgslave3
docker volume rm kbs_pgbackup

REM ###### Prune all unused volumes 
docker volume prune -f

REM ######################################################
REM Removing network...
REM ######################################################
docker network rm kbs_pgcluster
docker network rm kbs_core

REM ######################################################
REM List all
REM ######################################################
docker ps
docker volume ls
docker network ls

REM ......................................................
REM ######################################################
REM Uninstall finished!
REM ######################################################