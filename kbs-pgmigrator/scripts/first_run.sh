pre_start_action() {
  : # No-op
}

post_start_action() {
  echo "=============================="
  echo "=============================="

  cd ${IDEMPIERE_HOME}/utils  
  ./RUN_SyncDB.sh

  echo "=============================="
  echo "=============================="
  
  rm /firstrun
}
