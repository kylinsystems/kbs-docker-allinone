#!/bin/bash
echo "------------------------------------------------------------"
echo "####### Creating ENV "
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
