import os

from config.settings.boilerplate import BASE_DIR
from config.settings.environs import env

STATIC_URL = '/static/'
STATIC_ROOT = env('STATIC_ROOT', default='static')
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "assets"),
    os.path.join(BASE_DIR, "bundles"),
]
