from config.settings.environs import env

MEDIA_URL = '/media/'
MEDIA_ROOT = env('MEDIA_ROOT', default='media')
