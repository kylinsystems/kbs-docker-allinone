#!/bin/sh
#
# myEnvironment defines the variables used for idempiere
# 
#

echo Setting myEnvironment ....

#	Database ...
ADEMPIERE_DB_SERVER=kbs-pgserver
export ADEMPIERE_DB_SERVER
ADEMPIERE_DB_USER=idempiere_user
export ADEMPIERE_DB_USER
ADEMPIERE_DB_PASSWORD=idempiere_pass
export ADEMPIERE_DB_PASSWORD
ADEMPIERE_DB_URL=jdbc:postgresql://localhost:5432/idempiere_db
export ADEMPIERE_DB_URL
ADEMPIERE_DB_PORT=5432
export ADEMPIERE_DB_PORT

ADEMPIERE_DB_PATH=postgresql
export ADEMPIERE_DB_PATH
ADEMPIERE_DB_NAME=idempiere_db
export ADEMPIERE_DB_NAME
ADEMPIERE_DB_SYSTEM=postgres
export ADEMPIERE_DB_SYSTEM

#	Homes(1)
ADEMPIERE_DB_HOME=$IDEMPIERE_HOME/utils/$ADEMPIERE_DB_PATH
export ADEMPIERE_DB_HOME
