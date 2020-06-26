#!/bin/bash

echo "------------------------------------------------------------"
echo "####### Setup KBS Docker Suite"
echo "------------------------------------------------------------"

export KBS_TAG=7.1.0.latest
export KBS_DEBUG=true

export KBS_DB_HOST=kbs-pgserver
export KBS_DB_PORT=5432
export KBS_DB_NAME=idempiere_db
export KBS_DB_USER=adempiere
export KBS_DB_PASS=adempiere

export PORT_KBS=8080
export PORT_PORTAINER=9000
export PORT_PGADMIN4=9010

export MIGRATE_EXISTING_DATABASE=false

echo "------------------------------------------------------------"
echo "###### Creating data volume..."
echo "------------------------------------------------------------"
docker volume create --name=kbs_portainer_data
docker volume create --name=kbs_pg_data

echo "------------------------------------------------------------"
echo "###### Creating separate docker network..."
echo "------------------------------------------------------------"
docker network create -d bridge kbs_core

echo "------------------------------------------------------------"
echo "####### Building images..."
echo "------------------------------------------------------------"
docker-compose -f kbs-portainer/docker-compose.yml build
docker-compose -f kbs-pgsingle/docker-compose.yml build
docker-compose -f kbs-pgadmin4/docker-compose.yml build
docker-compose -f kbs-server/docker-compose.yml build

echo "------------------------------------------------------------"
echo "####### Starting..."
echo "------------------------------------------------------------"
docker-compose -f kbs-portainer/docker-compose.yml up --force-recreate -d
docker-compose -f kbs-pgsingle/docker-compose.yml up --force-recreate -d
docker-compose -f kbs-pgadmin4/docker-compose.yml up --force-recreate -d
docker-compose -f kbs-server/docker-compose.yml up --force-recreate -d

echo "------------------------------------------------------------"
echo "###### List all"
echo "------------------------------------------------------------"
docker network ls
docker volume ls
docker ps

echo "------------------------------------------------------------"
echo "###### Setup finished!"
echo "------------------------------------------------------------"

