#!/bin/sh
#

if [ $IDEMPIERE_HOME ]; then
  cd $IDEMPIERE_HOME/utils
fi
. ./myEnvironment.sh
echo Import iDempiere - $IDEMPIERE_HOME \($SEED_DB_NAME\)


echo == Start import seed database to seed instance ==

echo Re-Create idempiere User and import $IDEMPIERE_HOME/data/seed/${DB_DUMP_FILE} - \($SEED_DB_NAME\)
echo == The import will show warnings. This is OK ==
cd $IDEMPIERE_HOME/data/seed
cd ..
cd $IDEMPIERE_HOME/utils
ls -lsa $IDEMPIERE_HOME/data/seed/${DB_DUMP_FILE}

echo	Importing idempiere DB from $IDEMPIERE_HOME/data/seed/${DB_DUMP_FILE}

PGPASSWORD=$DB_SYSTEM
export PGPASSWORD

echo -------------------------------------
echo Recreate user and database
echo -------------------------------------
echo drop db $SEED_DB_NAME
dropdb -h $SEED_DB_SERVER -p $SEED_DB_PORT -U $DB_SYSTEM $SEED_DB_NAME
echo drop user $SEED_DB_USER
dropuser -h $SEED_DB_SERVER -p $SEED_DB_PORT -U $DB_SYSTEM $SEED_DB_USER

echo create role $SEED_DB_USER
CREATE_ROLE_SQL="CREATE ROLE $SEED_DB_USER SUPERUSER LOGIN PASSWORD '$SEED_DB_PASSWORD'"
psql -h $SEED_DB_SERVER -p $SEED_DB_PORT -U $DB_SYSTEM -c "$CREATE_ROLE_SQL"
CREATE_ROLE_SQL=

PGPASSWORD=$SEED_DB_PASSWORD
export PGPASSWORD

echo create db $SEED_DB_NAME
createdb  --template=template0 -h $SEED_DB_SERVER -p $SEED_DB_PORT -E UNICODE -O $SEED_DB_USER -U $SEED_DB_USER $SEED_DB_NAME

ALTER_ROLE_SQL="ALTER ROLE $SEED_DB_USER IN DATABASE $SEED_DB_NAME SET search_path TO $DB_SCHEMA, pg_catalog"
psql -h $SEED_DB_SERVER -p $SEED_DB_PORT -d $SEED_DB_NAME -U $SEED_DB_USER -c "$ALTER_ROLE_SQL"
psql -h $SEED_DB_SERVER -p $SEED_DB_PORT -d $SEED_DB_NAME -U $SEED_DB_USER -f $IDEMPIERE_HOME/data/seed/${DB_DUMP_FILE}
ALTER_ROLE_SQL=

#Reset PGPASSWORD
PGPASSWORD=
export PGPASSWORD

echo == End of inital seed instance. ==

