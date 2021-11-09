#!/usr/bin/env sh

set -o errexit
set -o nounset

readonly cmd="$*"

postgres_ready () {
  echo "postgres_ready"
dockerize -wait "tcp://${SQL_HOST:-db}:${SQL_PORT:-5432}" -timeout 10s
}

until postgres_ready; do
  >&2 echo 'Postgres is unavailable - sleeping'
done

>&2 echo 'Postgres is up - continuing...'

exec $cmd
