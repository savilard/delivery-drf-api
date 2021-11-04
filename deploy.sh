#!/bin/bash

. .env

REVISION=$(git rev-parse --verify HEAD)

source .venv/bin/activate
echo "Update code"
git pull
echo "Update deps"
pip install -r requirements.txt
npm install --include=dev
echo "Update frontend"
parcel build bundles-src/index.js --dist-dir bundles --public-url="./"
echo "Update Django static"
python manage.py collectstatic --noinput
echo "Migrate"
python manage.py migrate --noinput
echo "Restart starburger.service"
systemctl restart starburger.service
http POST https://api.rollbar.com/api/1/deploy/ access_token=$ROLLBAR_ACCESS_TOKEN environment=$ENVIRONMENT revision=$REVISION
echo "Deploy successfully completed"
