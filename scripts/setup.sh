#!/bin/bash
set -e

docker compose -f docker-compose.yml up frontend --build --force-recreate --no-deps
docker compose cp frontend:/opt/app/bundles/. ./src/backend/bundles
docker compose -f docker-compose.yml up backend db --build --force-recreate -d --no-deps

docker compose run backend python manage.py migrate --noinput
docker compose run backend python manage.py createsuperuser --noinput
