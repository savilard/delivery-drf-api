from django.contrib import admin
from django.shortcuts import reverse
from django.templatetags.static import static
from django.utils.html import format_html

from foodcartapp.admin.restaurant import RestaurantMenuItemInline
from foodcartapp.models import Product
from foodcartapp.models import ProductCategory


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = (
        'get_image_list_preview',
        'name',
        'category',
        'price',
    )
    list_display_links = (
        'name',
    )
    list_filter = (
        'category',
    )
    search_fields = (
        'name',
        'category__name',
    )
    inlines = (
        RestaurantMenuItemInline,
    )
    fieldsets = (
        (
            'Общее',
            {
                'fields': (
                    'name',
                    'category',
                    'image',
                    'get_image_preview',
                    'price',
                ),
            },
        ),
        (
            'Подробно',
            {
                'fields': (
                    'special_status',
                    'description',
                ),
                'classes': (
                    'wide',
                ),
            },
        ),
    )

    readonly_fields = (
        'get_image_preview',
    )

    class Media:
        css = {'all': (static('admin/foodcartapp.css/'))}

    @admin.display(description='превью')
    def get_image_preview(self, obj):
        if not obj.image:
            return 'выберите картинку'
        return format_html('<img src="{url}" style="max-height: 200px;"/>', url=obj.image.url)

    @admin.display(description='превью')
    def get_image_list_preview(self, obj):
        if not obj.image or not obj.id:
            return 'нет картинки'
        edit_url = reverse('admin:foodcartapp_product_change', args=(obj.id,))
        return format_html(
            '<a href="{edit_url}"><img src="{src}" style="max-height: 50px;"/></a>',
            edit_url=edit_url,
            src=obj.image.url,
        )


@admin.register(ProductCategory)
class ProductCategoryAdmin(admin.ModelAdmin):
    list_display = (
        'name',
    )
    search_fields = (
        'name',
    )
