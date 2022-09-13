from typing import Tuple

DJANGO_APPS: Tuple[str, ...] = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.admin',
)

THIRD_PARTY_APPS: Tuple[str, ...] = (
    'debug_toolbar',
    'phonenumber_field',
    'rest_framework',
)

LOCAL_APPS: Tuple[str, ...] = (
    'core.apps.CoreConfig',
    'foodcartapp.apps.FoodcartappConfig',
    'restaurateur.apps.RestaurateurConfig',
    'location.apps.LocationConfig',
)

INSTALLED_APPS = DJANGO_APPS + THIRD_PARTY_APPS + LOCAL_APPS
