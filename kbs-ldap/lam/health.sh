#!/bin/bash

wget -qO- http://localhost | grep -q '<title>LDAP Account Manager</title>'
