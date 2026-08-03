#!/bin/sh
set -eu
: "${FRIENDICA_ADMIN_MAIL:?FRIENDICA_ADMIN_MAIL is required}"
: "${FRIENDICA_ADMIN_PASSWORD:?FRIENDICA_ADMIN_PASSWORD is required}"
: "${FRIENDICA_ADMIN_NICK:?FRIENDICA_ADMIN_NICK is required}"
: "${MYSQL_HOST:?MYSQL_HOST is required}"
php /usr/src/friendica/bin/wait-for-connection "$MYSQL_HOST" "${MYSQL_PORT:-3306}" 300
exec /usr/local/bin/friendica-upstream-entrypoint apache-friendica-start
