#!/bin/sh
#

echo Setting myEnvironment ....

#   System Environment
ADEMPIERE_DB_PATH=postgresql
export ADEMPIERE_DB_PATH

#   Seed Database ...
SEED_DB_SERVER=${KBS_SEEDDB_HOST}
export SEED_DB_SERVER
SEED_DB_NAME=${KBS_SEEDDB_NAME}
export SEED_DB_NAME
SEED_DB_USER=${KBS_SEEDDB_USER}
export SEED_DB_USER
SEED_DB_PASSWORD=${KBS_SEEDDB_PASS}
export SEED_DB_PASSWORD
SEED_DB_PORT=${KBS_SEEDDB_PORT}
export SEED_DB_PORT

#   Target Database ...
TARGET_DB_SERVER=${KBS_DB_HOST}
export TARGET_DB_SERVER
TARGET_DB_NAME=${KBS_DB_NAME}
export TARGET_DB_NAME
TARGET_DB_USER=${KBS_DB_USER}
export TARGET_DB_USER
TARGET_DB_PASSWORD=${KBS_DB_PASS}
export TARGET_DB_PASSWORD
TARGET_DB_PORT=${KBS_DB_PORT}
export TARGET_DB_PORT
