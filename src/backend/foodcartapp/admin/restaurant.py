from django.contrib import admin

from foodcartapp.models import Restaurant
from foodcartapp.models import RestaurantMenuItem


class RestaurantMenuItemInline(admin.TabularInline):
    model = RestaurantMenuItem
    extra = 0


@admin.register(Restaurant)
class RestaurantAdmin(admin.ModelAdmin):
    search_fields = (
        'name',
        'address',
        'contact_phone',
    )
    list_display = (
        'name',
        'address',
        'contact_phone',
    )
    inlines = (
        RestaurantMenuItemInline,
    )
