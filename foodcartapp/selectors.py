from typing import List

from geopy import distance

from foodcartapp.models import Order, RestaurantMenuItem
from location.models import Location


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

    return calculate_distances_to_order(
        restaurants=set.intersection(*map(set, restaurants_with_products_from_order)),
        order_address=order.address,
    )


def get_location(address: str):
    location, is_created = Location.objects.get_or_create(address=address)
    if not is_created:
        return location

    lon, lat = Location.fetch_coordinates(address)
    location.lat = lat
    location.lon = lon
    location.save()
    return location


def calculate_distances_to_order(restaurants, order_address: str):
    order_location = get_location(order_address)

    restaurants_with_order_distance = []
    for restaurant in restaurants:
        restaurant_location = get_location(restaurant.address)
        distance_between_restaurant_and_order = distance.distance(
            (order_location.lat, order_location.lon), (restaurant_location.lat, restaurant_location.lon),
        ).km
        restaurants_with_order_distance.append(
            {
                'restaurant': restaurant,
                'order_distance': round(distance_between_restaurant_and_order, 2),
            }
        )
    return sorted(restaurants_with_order_distance, key=lambda restaurant: restaurant['order_distance'])
