from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import render

from core.helpers import is_manager
from foodcartapp.models import Product
from foodcartapp.models import Restaurant


@user_passes_test(is_manager, login_url='restaurateur:login')
def view_products(request):  # noqa: WPS210
    """Shows products in the manager's admin panel."""
    restaurants = list(Restaurant.objects.order_by('name'))
    products = list(Product.objects.prefetch_related('menu_items'))

    default_availability = {restaurant.id: False for restaurant in restaurants}
    products_with_restaurants = []
    for product in products:
        availability = {
            **default_availability,
            **{menu_item.restaurant_id: menu_item.availability for menu_item in product.menu_items.all()},
        }
        order_availability = [availability[restaurant.id] for restaurant in restaurants]

        products_with_restaurants.append((product, order_availability))

    return render(
        request,
        template_name='products_list.html',
        context={
            'products_with_restaurants': products_with_restaurants,
            'restaurants': restaurants,
        },
    )
