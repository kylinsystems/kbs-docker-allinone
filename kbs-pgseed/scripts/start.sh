#!/bin/bash
# Starts up postgresql within the container.

# Stop on error
set -e

DATA_DIR=/data

if [[ -e /firstrun ]]; then
  echo "First run of pgseed"
  source /scripts/first_run.sh
else
  echo "Normal run of pgseed"
  source /scripts/normal_run.sh
fi

wait_for_postgres_and_run_post_start_action() {
  # Wait for postgres to finish starting up first.
  while [[ ! -e /run/postgresql/$PG_MAJOR-main.pid ]] ; do
      inotifywait -q -e create /run/postgresql/ >> /dev/null
  done
  sleep 3s
  post_start_action
}

pre_start_action

wait_for_postgres_and_run_post_start_action &


# Start PostgreSQL
echo "Starting PostgreSQL..."
setuser postgres /usr/lib/postgresql/$PG_MAJOR/bin/postgres -D /etc/postgresql/$PG_MAJOR/main
