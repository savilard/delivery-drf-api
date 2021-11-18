#!/bin/bash

. .env

REVISION=$(git rev-parse --verify HEAD)

git pull
echo "Update django app"
DOCKER_BUILDKIT=1 docker-compose -f docker-compose.prod.yml up --build --force-recreate --no-deps -d server
echo "Update npm deps"
npm install --include=dev
echo "Update frontend"
parcel build bundles-src/index.js --dist-dir bundles --public-url="./"
echo "Update Django static"
docker compose exec server python manage.py migrate --noinput
.venv/bin/http POST https://api.rollbar.com/api/1/deploy/ access_token=$ROLLBAR_ACCESS_TOKEN environment=$ROLLBAR_ENVIRONMENT revision=$REVISION
echo "Deploy successfully completed"
