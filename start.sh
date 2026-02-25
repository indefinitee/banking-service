#!/bin/sh

set -e 

echo "Running db migration"
/app/migrate -path /app/migration -database "$DB_SOURCE" -verbose up

echo "Start the app"
exec "$@"