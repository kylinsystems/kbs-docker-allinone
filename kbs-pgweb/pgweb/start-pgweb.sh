#!/bin/bash
# Starts up pgweb within the container.

# Stop on error
set -e

# Start pgweb
/app/pgweb_linux_amd64 --bind=0.0.0.0 --listen=$LISTEN_PORT --readonly --prefix=pgweb --lock-session --url=postgres://$PG_USER:$PG_PASSWORD@$PG_HOST_NAME:$PG_HOST_PORT/$PG_DB?sslmode=disable --auth-user=$PGWEB_AUTH_USER --auth-pass=$PGWEB_AUTH_PASS
