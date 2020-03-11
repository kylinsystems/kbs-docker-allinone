#!/bin/sh
#

echo Setting myEnvironment ....

#   System Environment
ADEMPIERE_DB_PATH=postgresql
export ADEMPIERE_DB_PATH

#   Target Database ...
DB_SERVER=${KBS_DB_HOST}
export DB_SERVER
DB_NAME=${KBS_DB_NAME}
export DB_NAME
DB_USER=${KBS_DB_USER}
export DB_USER
DB_PASS=${KBS_DB_PASS}
export DB_PASS
DB_PORT=${KBS_DB_PORT}
export DB_PORT
