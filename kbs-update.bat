REM ######################################################
REM Updating KBS Docker Suite
REM ######################################################
REM ......................................................
call env.bat

REM ######################################################
REM Building images...
REM ######################################################
docker-compose -f kbs-pgmigrator/docker-compose.yml build
docker-compose -f kbs-server/docker-compose.yml build

REM ######################################################
REM Starting...
REM ######################################################
docker-compose -f kbs-pgmigrator/docker-compose.yml up --force-recreate

docker-compose -f kbs-server/docker-compose.yml up --force-recreate -d
REM ###### waiting 60s to complete start kbs-server
ping -n 60 127.1 >nul

REM ######################################################
REM List all
REM ######################################################
docker network ls
docker volume ls
docker ps

REM ......................................................
REM ######################################################
REM Update finished!
REM ######################################################