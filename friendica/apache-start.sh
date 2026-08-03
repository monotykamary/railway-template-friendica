#!/bin/sh
set -eu
cd /var/www/html

if ! gosu www-data php bin/console.php user search mail "$FRIENDICA_ADMIN_MAIL" 2>/dev/null | grep -Fq "$FRIENDICA_ADMIN_MAIL"; then
  gosu www-data php bin/console.php user add "Railway Admin" "$FRIENDICA_ADMIN_NICK" "$FRIENDICA_ADMIN_MAIL" en "${FRIENDICA_URL%/}/images/friendica-256.png"
fi
gosu www-data php bin/console.php user password "$FRIENDICA_ADMIN_NICK" "$FRIENDICA_ADMIN_PASSWORD"
if ! gosu www-data php bin/console.php config system register_policy 2>/dev/null | grep -Eq '=> 0$'; then
  gosu www-data php bin/console.php config system register_policy 0
fi
if ! gosu www-data php bin/console.php config system ssl_policy 2>/dev/null | grep -Eq '=> 1$'; then
  gosu www-data php bin/console.php config system ssl_policy 1
fi

cat > healthz.php <<'PHP'
<?php
header('Content-Type: application/json');
$version = is_file(__DIR__ . '/VERSION') ? trim(file_get_contents(__DIR__ . '/VERSION')) : 'unknown';
try {
    $dsn = sprintf('mysql:host=%s;port=%d;dbname=%s', getenv('MYSQL_HOST'), (int) (getenv('MYSQL_PORT') ?: 3306), getenv('MYSQL_DATABASE'));
    $db = new PDO($dsn, getenv('MYSQL_USER'), getenv('MYSQL_PASSWORD'), [PDO::ATTR_TIMEOUT => 2, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
    $db->query('SELECT 1');
    echo json_encode(['status' => 'pass', 'version' => $version]);
} catch (Throwable $error) {
    http_response_code(503);
    echo json_encode(['status' => 'fail', 'version' => $version]);
}
PHP
chown www-data:www-data healthz.php

host=${FRIENDICA_URL#*://}
host=${host%%/*}
host=${host%%:*}
printf "ServerName %s\n" "$host" >> /etc/apache2/apache2.conf

unset FRIENDICA_ADMIN_PASSWORD
gosu www-data php bin/console.php daemon start -f &
exec apache2-foreground
