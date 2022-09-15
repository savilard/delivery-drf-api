from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import render

from core.check_user import is_manager
from foodcartapp.models import Order
from foodcartapp.models import RestaurantMenuItem
from foodcartapp.selectors import get_restaurants_with_products_from_order
from restaurateur.serializers import serialize_order


@user_passes_test(is_manager, login_url='restaurateur:login')
def view_orders(request):
    """Shows orders in the manager's admin panel."""
    orders = Order.objects.prefetch_related('order_products__product').only_unprocessed().with_coords_from_cache()
    sorted_orders = orders.order_by('-id')

    products_in_restaurants = (
        RestaurantMenuItem.objects.select_related(
            'restaurant',
            'product',
        ).filter(
            availability=True,
        ).with_restaurant_coords_from_cache()
    )

    return render(
        request,
        template_name='order_items.html',
        context={
            'order_items': [
                serialize_order(
                    order,
                    get_restaurants_with_products_from_order(
                        order,
                        products_in_restaurants,
                    ),
                )
                for order in sorted_orders
            ],
        },
    )
