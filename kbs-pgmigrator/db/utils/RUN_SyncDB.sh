#!/bin/sh

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh

ADEMPIERE_DB_SERVER=$DB_SERVER
export ADEMPIERE_DB_SERVER
ADEMPIERE_DB_PORT=$DB_PORT
export ADEMPIERE_DB_PORT
ADEMPIERE_DB_USER=$DB_USER
export ADEMPIERE_DB_USER
ADEMPIERE_DB_PASSWORD=$DB_PASS
export ADEMPIERE_DB_PASSWORD

# echo "===================================="
# echo "--Start SyncDB to Seed Database--"

# ADEMPIERE_DB_NAME=$SEED_DB_NAME
# export ADEMPIERE_DB_NAME

# sh $ADEMPIERE_DB_PATH/SyncDB.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH"
# echo "--Done : SyncDB to Seed Database--"

echo "===================================="
echo "--Start SyncDB to Target Database--"

ADEMPIERE_DB_NAME=$DB_NAME
export ADEMPIERE_DB_NAME

sh $ADEMPIERE_DB_PATH/SyncDB.sh "$ADEMPIERE_DB_USER" "$ADEMPIERE_DB_PASSWORD" "$ADEMPIERE_DB_PATH"
echo "--Done : SyncDB to Target Database--"
