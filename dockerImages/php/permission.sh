#!/bin/sh

set -e

# Change var folder permissions
chown -R :www-data /var/www/sdocker/var/\
    /var/www/sdocker/public/

chmod -R g+w /var/www/sdocker/var/ \
	/var/www/sdocker/public/

exec "$@"