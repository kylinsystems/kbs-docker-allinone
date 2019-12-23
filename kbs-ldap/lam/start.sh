#! /bin/bash -e

echo "restore configuration"
for f in $DATA $CONFIG; do
    rsync -a --ignore-existing $f.original/ $f/
    chown -R www-data.www-data $f
done

! test -f /run/apache2/apache2.pid || rm /run/apache2/apache2.pid
apache2ctl -DFOREGROUND
