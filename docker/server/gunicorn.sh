#!/usr/bin/env sh

set -o errexit
set -o nounset

gunicorn star_burger.wsgi:application \
    --workers=5 \
    --max-requests=2000 \
    --max-requests-jitter=400 \
    --worker-class=gthread \
    --bind 0.0.0.0:8000 \
    --log-file=- \
    --worker-tmp-dir='/dev/shm'
