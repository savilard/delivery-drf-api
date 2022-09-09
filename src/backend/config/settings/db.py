import dj_database_url

DATABASES = {'default': dj_database_url.config()}

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
