from config.settings.boilerplate import BASE_DIR
from config.settings.environs import env

ROLLBAR = {
    'access_token': env.str('ROLLBAR_ACCESS_TOKEN', ''),
    'environment': env.str('ROLLBAR_ENVIRONMENT', default='development'),
    'root': BASE_DIR,
}
