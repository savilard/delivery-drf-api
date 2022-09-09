from django.conf import settings
from django.contrib import admin
from django.http import HttpResponseRedirect
from django.shortcuts import reverse
from django.templatetags.static import static
from django.utils.html import format_html
from django.utils.http import url_has_allowed_host_and_scheme

from location.models import Location
from .models import Order, OrderProduct
from .models import Product
from .models import ProductCategory
from .models import Restaurant
from .models import RestaurantMenuItem


class RestaurantMenuItemInline(admin.TabularInline):
    model = RestaurantMenuItem
    extra = 0


@admin.register(Restaurant)
class RestaurantAdmin(admin.ModelAdmin):
    search_fields = [
        'name',
        'address',
        'contact_phone',
    ]
    list_display = [
        'name',
        'address',
        'contact_phone',
    ]
    inlines = [
        RestaurantMenuItemInline
    ]


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = [
        'get_image_list_preview',
        'name',
        'category',
        'price',
    ]
    list_display_links = [
        'name',
    ]
    list_filter = [
        'category',
    ]
    search_fields = [
        # FIXME SQLite can not convert letter case for cyrillic words properly, so search will be buggy.
        # Migration to PostgreSQL is necessary
        'name',
        'category__name',
    ]

    inlines = [
        RestaurantMenuItemInline
    ]
    fieldsets = (
        ('Общее', {
            'fields': [
                'name',
                'category',
                'image',
                'get_image_preview',
                'price',
            ]
        }),
        ('Подробно', {
            'fields': [
                'special_status',
                'description',
            ],
            'classes': [
                'wide'
            ],
        }),
    )

    readonly_fields = [
        'get_image_preview',
    ]

    class Media:
        css = {
            "all": (
                static("admin/foodcartapp.css/")
            )
        }

    def get_image_preview(self, obj):
        if not obj.image:
            return 'выберите картинку'
        return format_html('<img src="{url}" style="max-height: 200px;"/>', url=obj.image.url)

    get_image_preview.short_description = 'превью'

    def get_image_list_preview(self, obj):
        if not obj.image or not obj.id:
            return 'нет картинки'
        edit_url = reverse('admin:foodcartapp_product_change', args=(obj.id,))
        return format_html('<a href="{edit_url}"><img src="{src}" style="max-height: 50px;"/></a>', edit_url=edit_url,
                           src=obj.image.url)

    get_image_list_preview.short_description = 'превью'


@admin.register(ProductCategory)
class ProductAdmin(admin.ModelAdmin):
    pass


class OrderProductInLine(admin.TabularInline):
    model = OrderProduct
    extra = 0

    fields = [
        'product',
        'quantity',
        'cost',
    ]


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = [
        'id',
        'phonenumber',
        'firstname',
        'lastname',
        'address',
    ]
    list_display_links = [
        'phonenumber',
    ]
    inlines = [OrderProductInLine]

    def response_change(self, request, obj):
        response = super(OrderAdmin, self).response_change(request, obj)

        redirect_url = request.GET.get('next')
        if not redirect_url:
            return response

        is_url_safe = url_has_allowed_host_and_scheme(
            url=redirect_url,
            allowed_hosts=settings.ALLOWED_HOSTS,
        )

        if "next" in request.GET and is_url_safe:
            return HttpResponseRedirect(redirect_url)
        else:
            return response

    def save_model(self, request, obj, form, change):
        address = obj.address
        coords = Location.fetch_coordinates(address)
        if coords:
            Location.objects.get_or_create(address=address, lat=coords.lat, lon=coords.lon)
            super().save_model(request, obj, form, change)
        else:
            super().save_model(request, obj, form, change)
