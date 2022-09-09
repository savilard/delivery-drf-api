from config.settings.environs import env

ALLOWED_HOSTS = [
    env.str('SERVER_NAME', ''),
    'localhost',
    '0.0.0.0',
    '127.0.0.1',
    '[::1]',
]
