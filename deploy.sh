#!/bin/bash

. .env

REVISION=$(git rev-parse --verify HEAD)

git pull
DOCKER_BUILDKIT=1 docker-compose -f docker-compose.prod.yml up --build --force-recreate --no-deps -d parcel
DOCKER_BUILDKIT=1 docker-compose -f docker-compose.prod.yml up --build --force-recreate --no-deps -d server
docker compose exec server python manage.py migrate --noinput
docker compose exec server http POST https://api.rollbar.com/api/1/deploy/ access_token=$ROLLBAR_ACCESS_TOKEN environment=$ROLLBAR_ENVIRONMENT revision=$REVISION
echo "Deploy successfully completed"
