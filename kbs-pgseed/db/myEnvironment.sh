#!/bin/sh
#

echo Setting myEnvironment ....

# Dump File
DB_DUMP_FILE=Adempiere_pg.dmp
export DB_DUMP_FILE

#   System Environment
DB_PATH=postgresql
export PB_PATH
DB_SYSTEM=postgres
export DB_SYSTEM
DB_HOME=$IDEMPIERE_HOME/utils/$DB_PATH
export DB_HOME
DB_SCHEMA=adempiere
export DB_SCHEMA

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
TARGET_DB_USER_RO=kbs_read_only
export TARGET_DB_USER_RO
TARGET_DB_PASSWORD_RO=read_only_pass
export TARGET_DB_PASSWORD_RO