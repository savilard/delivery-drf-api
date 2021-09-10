from typing import List

from foodcartapp.models import Order, RestaurantMenuItem


def get_restaurants_with_products_from_order(order: Order, products_in_restaurants: List[RestaurantMenuItem]):

    order_products = order.order_products.all()
    restaurants_with_products_from_order = []

    for order_product in order_products:
        restaurants_with_products_from_order.append(
            [
                product_in_restaurants.restaurant
                for product_in_restaurants in products_in_restaurants
                if product_in_restaurants.product == order_product.product
            ]
        )
    return set.intersection(*map(set, restaurants_with_products_from_order))
