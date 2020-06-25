#!/bin/bash

echo "------------------------------------------------------------"
echo "####### Updating KBS Docker Suite"
echo "------------------------------------------------------------"

./env.sh

MIGRATE_EXISTING_DATABASE=true
export MIGRATE_EXISTING_DATABASE

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
