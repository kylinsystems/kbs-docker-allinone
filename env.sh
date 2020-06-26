#!/bin/bash
echo "------------------------------------------------------------"
echo "####### Creating ENV "
echo "------------------------------------------------------------"

KBS_TAG=7.1.0.latest
KBS_DEBUG=true

KBS_DB_HOST=kbs-pgserver
KBS_DB_PORT=5432
KBS_DB_NAME=idempiere_db
KBS_DB_USER=adempiere
KBS_DB_PASS=adempiere

PORT_KBS=8080
PORT_PORTAINER=9000
PORT_PGADMIN4=9010
