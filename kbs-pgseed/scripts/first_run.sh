pre_start_action() {
  : # No-op
}

post_start_action() {

  echo "=============================="
  echo "=============================="

  cd ${IDEMPIERE_DB_HOME}/utils
  ./RUN_ImportIdempiere.sh -y --force-yes

  echo "=============================="
  echo "=============================="

  rm /firstrun
}
