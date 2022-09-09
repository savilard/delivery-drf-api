from split_settings.tools import include

_base_settings = (
    './auth.py',
    './base.py',
    './boilerplate.py',
    './debug_toolbar.py',
    './db.py',
    './environs.py',
    './i18n.py',
    './installed_apps.py',
    './http.py',
    './media.py',
    './middleware.py',
    './rollbar.py',
    './static.py',
    './templates.py',
    './timezone.py',
    './ya_geocoder.py',
)

include(*_base_settings)
