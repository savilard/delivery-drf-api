#!/bin/bash
echo "Update code"
git pull
echo "Update deps"
source .venv/bin/activate
pip install -r requirements.txt
npm install --include=dev
echo "Update frontend"
parcel build bundles-src/index.js --dist-dir bundles --public-url="./"
echo "Update Django static"
python manage.py collectstatic --clear --noinput
echo "Migrate"
python manage.py migrate --noinput
echo "Restart starburger.service"
systemctl restart starburger.service
echo "Deploy successfully completed"
