#!/bin/sh
#

if [ $IDEMPIERE_DB_HOME ]; then
  cd $IDEMPIERE_DB_HOME/utils
fi
. ./myEnvironment.sh

echo == Starting setup database instance ==

cd $IDEMPIERE_DB_HOME/utils
ls -lsa $IDEMPIERE_DB_HOME/data/seed/${DB_DUMP_FILE}

echo	Importing DB from $IDEMPIERE_DB_HOME/data/seed/${DB_DUMP_FILE}

PGPASSWORD=$DB_PASS
export PGPASSWORD

echo --------------------------------------------------------------------------
echo Create Database Instance : $DB_NAME
echo --------------------------------------------------------------------------
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -f $IDEMPIERE_DB_HOME/data/seed/${DB_DUMP_FILE}

SQL_STRING="ALTER ROLE $DB_USER IN DATABASE $DB_NAME SET search_path TO $DB_SCHEMA, pg_catalog"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

echo --------------------------------------------------------------------------
echo Create Readonly User : $DB_USER_RO
echo --------------------------------------------------------------------------
SQL_STRING="CREATE ROLE $DB_USER_RO WITH LOGIN PASSWORD '$DB_PASS_RO' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity'"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="GRANT CONNECT ON DATABASE $DB_NAME TO $DB_USER_RO"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="ALTER ROLE $DB_USER_RO IN DATABASE $DB_NAME SET search_path TO $DB_SCHEMA, pg_catalog"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="GRANT USAGE ON SCHEMA $DB_SCHEMA TO $DB_USER_RO"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="GRANT SELECT ON ALL TABLES IN SCHEMA $DB_SCHEMA TO $DB_USER_RO"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="GRANT SELECT ON ALL SEQUENCES IN SCHEMA $DB_SCHEMA TO $DB_USER_RO"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

SQL_STRING="ALTER DEFAULT PRIVILEGES IN SCHEMA $DB_SCHEMA GRANT SELECT ON TABLES TO $DB_USER_RO"
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

echo --------------------------------------------------------------------------
echo Create EXTENSION : pg_stat_statements
echo --------------------------------------------------------------------------
SQL_STRING="CREATE EXTENSION pg_stat_statements"  
psql -h $DB_SERVER -p $DB_PORT -d $DB_NAME -U $DB_USER -c "$SQL_STRING"

#Reset SQL
SQL_STRING=
#Reset PGPASSWORD
PGPASSWORD=
export PGPASSWORD

echo == End of inital database instance. ==