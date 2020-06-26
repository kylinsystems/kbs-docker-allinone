#!/bin/bash

echo "------------------------------------------------------------"
echo "####### Setup KBS Docker Suite"
echo "------------------------------------------------------------"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source $DIR/env.sh

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
read -n 1 -p "Press any key to continue..."
