#!/bin/bash
# Starts up pgmigrator within the container.

# Stop on error
set -e

if [[ -e /firstrun ]]; then
  echo "First run of pgmigrator"
  source /scripts/first_run.sh
else
  echo "Normal run of pgmigrator"
  source /scripts/normal_run.sh
fi

pre_start_action

post_start_action


# Migration done
