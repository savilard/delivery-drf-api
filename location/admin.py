from django.contrib import admin

from location.models import Location


@admin.register(Location)
class LocationAdmin(admin.ModelAdmin):
    list_display = [
        'id',
        'address',
        'lat',
        'lon',
        'created_at',
    ]
