USER=${USER:-postgres}
PASS=${PASS:-$(pwgen -s -1 16)}

pre_start_action() {
  # Echo out info to later obtain by running `docker logs container_name`
  echo "POSTGRES_USER=$USER"
  echo "POSTGRES_PASS=$PASS"
  echo "POSTGRES_DATA_DIR=$DATA_DIR"
  if [ $(env | grep DB) ]; then echo "POSTGRES_DATABASE=$DB";fi

  # test if DATA_DIR has content
  if [[ ! "$(ls -A $DATA_DIR)" ]]; then
      echo "Initializing PostgreSQL at $DATA_DIR"

      # Copy the data that we generated within the container to the empty DATA_DIR.
      mkdir $DATA_DIR
      cp -R /var/lib/postgresql/$PG_MAJOR/main/* $DATA_DIR
  fi

  # Ensure postgres owns the DATA_DIR
  chown -R postgres $DATA_DIR
  # Ensure we have the right permissions set on the DATA_DIR
  chmod -R 700 $DATA_DIR
}

post_start_action() {
  echo "Seed Database Instance"

  echo "1/3. Init the superuser: $USER"
	setuser postgres psql -q <<-EOF
	   ALTER USER $USER WITH ENCRYPTED PASSWORD 'postgres';
	   ALTER ROLE $USER WITH SUPERUSER;
	   ALTER ROLE $USER WITH LOGIN;
	EOF

  echo "2/3. Import to Seed Database"
  cd ${IDEMPIERE_DB_HOME}/utils
  ./RUN_ImportIdempiere_seed.sh -y --force-yes

  echo "3/3. Reset password for superuser: $USER"
	setuser postgres psql -q <<-EOF
	   ALTER USER $USER WITH ENCRYPTED PASSWORD '$PASS';
	   ALTER ROLE $USER WITH SUPERUSER;
	   ALTER ROLE $USER WITH LOGIN;
	EOF

  echo "Done. (Seed Database)"

  echo "==============="
  echo "==============="

  echo "Target Database Instance"

  echo "1/1. Import to Target Database"
  cd ${IDEMPIERE_DB_HOME}/utils
  ./RUN_ImportIdempiere_target.sh -y --force-yes

  echo "Done. (Target Database)"

  rm /firstrun
}
