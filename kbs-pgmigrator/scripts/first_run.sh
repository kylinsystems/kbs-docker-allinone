pre_start_action() {
  : # No-op
}

post_start_action() {

  cd ${IDEMPIERE_HOME}/utils  
  ./RUN_SyncDB.sh

  rm /firstrun
}
