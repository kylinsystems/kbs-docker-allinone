#!/bin/bash

echo "------------------------------------------------------------"
echo "####### Updating KBS Docker Suite"
echo "------------------------------------------------------------"

export KBS_TAG=8.2.0.latest
export KBS_DEBUG=true

export KBS_DB_HOST=kbs-pgserver
export KBS_DB_PORT=5432
export KBS_DB_NAME=idempiere_db
export KBS_DB_USER=adempiere
export KBS_DB_PASS=adempiere

export PORT_KBS=8080
export PORT_PORTAINER=9000
export PORT_PGADMIN4=9010

export MIGRATE_EXISTING_DATABASE=true

echo "------------------------------------------------------------"
echo "###### Building images..."
echo "------------------------------------------------------------"
docker-compose -f kbs-server/docker-compose.yml build

echo "------------------------------------------------------------"
echo "####### Starting..."
echo "------------------------------------------------------------"
docker-compose -f kbs-server/docker-compose.yml up --force-recreate -d

echo "------------------------------------------------------------"
echo "###### List all"
echo "------------------------------------------------------------"
docker network ls
docker volume ls
docker ps

echo "------------------------------------------------------------"
echo "###### Update finished!"
echo "------------------------------------------------------------"
read -n 1 -p "Press any key to continue..."
