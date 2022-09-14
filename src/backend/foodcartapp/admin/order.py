from django.conf import settings
from django.contrib import admin
from django.http import HttpResponseRedirect
from django.utils.http import url_has_allowed_host_and_scheme

from foodcartapp.models import Order
from foodcartapp.models import OrderProduct
from location.models import Location


class OrderProductInLine(admin.TabularInline):
    model = OrderProduct
    extra = 0

    fields = (
        'product',
        'quantity',
        'cost',
    )


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = (
        'id',
        'phonenumber',
        'firstname',
        'lastname',
        'address',
    )
    list_display_links = (
        'phonenumber',
    )
    inlines = (
        OrderProductInLine,
    )

    def response_change(self, request, obj):
        response = super().response_change(request, obj)

        redirect_url = request.GET.get('next')
        if not redirect_url:
            return response

        is_url_safe = url_has_allowed_host_and_scheme(
            url=redirect_url,
            allowed_hosts=settings.ALLOWED_HOSTS,
        )

        if 'next' in request.GET and is_url_safe:
            return HttpResponseRedirect(redirect_url)
        return response

    def save_model(self, request, obj, form, change):
        address = obj.address
        coords = Location.fetch_coordinates(address)
        if coords:
            Location.objects.get_or_create(address=address, lat=coords.lat, lon=coords.lon)
            super().save_model(request, obj, form, change)
        else:
            super().save_model(request, obj, form, change)
