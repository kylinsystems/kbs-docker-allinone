#!/bin/bash

echo "------------------------------------------------------------"
echo "####### Uninstalling KBS Docker Suite"
echo "------------------------------------------------------------"

./env.sh

echo "------------------------------------------------------------"
echo "###### Stopping and removing containers..."
echo "------------------------------------------------------------"
docker-compose -f kbs-server/docker-compose.yml down -v
docker-compose -f kbs-pgadmin4/docker-compose.yml down -v
docker-compose -f kbs-pgsingle/docker-compose.yml down -v
docker-compose -f kbs-portainer/docker-compose.yml down -v

echo "###### Prune all stopped containers"
docker container prune -f

echo "------------------------------------------------------------"
echo "###### Removing data volume..."
echo "------------------------------------------------------------"
docker volume rm kbs_portainer_data
docker volume rm kbs_pg_data

echo "###### Prune all unused volumes "
docker volume prune -f

echo "------------------------------------------------------------"
echo "####### Removing network..."
echo "------------------------------------------------------------"
docker network rm kbs_core

echo "------------------------------------------------------------"
echo "####### List all"
echo "------------------------------------------------------------"
docker ps
docker volume ls
docker network ls

echo "------------------------------------------------------------"
echo "###### Uninstall finished!"
echo "------------------------------------------------------------"

read -n 1 -p "Press any key to continue..."
