#!/bin/bash
set -e

docker compose -f docker-compose.yml up frontend --build --force-recreate --no-deps
docker compose cp frontend:/opt/app/bundles/. ./src/backend/bundles
docker compose -f docker-compose.yml up backend --build --force-recreate -d --no-deps

docker compose up db -d
docker compose run --rm backend sh -c "python manage.py wait_for_db"
docker compose exec db psql -U app_dev -f /backup/postgres-test-data.sql
docker compose down
