#!/bin/sh
#

echo Setting myEnvironment ....

# Dump File
DB_DUMP_FILE=Adempiere_pg.dmp
export DB_DUMP_FILE

#   System Environment
DB_PATH=postgresql
export DB_PATH
DB_SYSTEM=postgres
export DB_SYSTEM
DB_HOME=$IDEMPIERE_HOME/utils/$DB_PATH
export DB_HOME
DB_SCHEMA=adempiere
export DB_SCHEMA

#   Target Database ...
DB_SERVER=${KBS_DB_HOST}
export DB_SERVER
DB_NAME=${KBS_DB_NAME}
export DB_NAME
DB_PORT=${KBS_DB_PORT}
export DB_PORT
#   Database User
DB_USER=${KBS_DB_USER}
export DB_USER
DB_PASS=${KBS_DB_PASS}
export DB_PASS
#   Database ReadOnly User
DB_USER_RO=${KBS_DB_USER_RO}
export DB_USER_RO
DB_PASS_RO=${KBS_DB_PASS_RO}
export DB_PASS_RO
