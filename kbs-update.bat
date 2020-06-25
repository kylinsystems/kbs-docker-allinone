REM ######################################################
REM Updating KBS Docker Suite
REM ######################################################
REM ......................................................
call env.bat

set MIGRATE_EXISTING_DATABASE=true

REM ######################################################
REM Building images...
REM ######################################################
docker-compose -f kbs-server/docker-compose.yml build

REM ######################################################
REM Starting...
REM ######################################################
docker-compose -f kbs-server/docker-compose.yml up --force-recreate -d

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