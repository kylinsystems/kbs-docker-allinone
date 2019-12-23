#!/bin/sh
#

echo Setting myEnvironment ....

#   System Environment
ADEMPIERE_DB_PATH=postgresql
export ADEMPIERE_DB_PATH

#   Seed Database ...
SEED_DB_SERVER=kbs-pgseed
export SEED_DB_SERVER
SEED_DB_NAME=idempiere
export SEED_DB_NAME
SEED_DB_USER=adempiere
export SEED_DB_USER
SEED_DB_PASSWORD=adempiere
export SEED_DB_PASSWORD
SEED_DB_PORT=5432
export SEED_DB_PORT

#   Target Database ...
TARGET_DB_SERVER=kbs-pgserver
export TARGET_DB_SERVER
TARGET_DB_NAME=idempiere_db
export TARGET_DB_NAME
TARGET_DB_USER=idempiere_user
export TARGET_DB_USER
TARGET_DB_PASSWORD=idempiere_pass
export TARGET_DB_PASSWORD
TARGET_DB_PORT=5432
export TARGET_DB_PORT
