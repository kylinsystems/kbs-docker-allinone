REM ######################################################
REM Uninstalling KBS Docker Suite
REM ######################################################
REM ......................................................
call env.bat

REM ######################################################
REM Stopping and removing containers...
REM ######################################################
REM ### KBS ###
docker-compose -f kbs-server/docker-compose.yml down -v
docker-compose -f kbs-greenmail/docker-compose.yml down -v
docker-compose -f kbs-pgadmin4/docker-compose.yml down -v
docker-compose -f kbs-pgsingle/docker-compose.yml down -v
docker-compose -f kbs-portainer/docker-compose.yml down -v

REM ###### Prune all stopped containers
docker container prune -f

REM ######################################################
REM Removing data volume...
REM ######################################################
docker volume rm kbs_portainer_data
docker volume rm kbs_pg_data

REM ###### Prune all unused volumes 
docker volume prune -f

REM ######################################################
REM Removing network...
REM ######################################################
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