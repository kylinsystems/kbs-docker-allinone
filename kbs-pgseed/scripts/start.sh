#!/bin/bash

# Stop on error
set -e

if [[ -e /firstrun ]]; then
  echo "First run of pgseed"
  source /scripts/first_run.sh
else
  echo "Normal run of pgseed"
  source /scripts/normal_run.sh
fi

pre_start_action

post_start_action

