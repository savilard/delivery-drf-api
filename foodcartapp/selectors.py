from typing import List

from geopy import distance

from foodcartapp.location import fetch_coordinates
from foodcartapp.models import Order, RestaurantMenuItem
from star_burger import settings


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
        ya_geocoder_api_key=settings.YANDEX_GEOCODER_APIKEY,
        order_address=order.address,
    )


def calculate_distances_to_order(restaurants, ya_geocoder_api_key: str, order_address: str):
    order_lon, order_lat = fetch_coordinates(apikey=ya_geocoder_api_key, place=order_address)
    restaurants_with_order_distance = []
    for restaurant in restaurants:
        restaurant_lon, restaurant_lat = fetch_coordinates(apikey=ya_geocoder_api_key, place=restaurant.address)
        distance_between_restoraunt_and_order = distance.distance(
            (order_lat, order_lon), (restaurant_lat, restaurant_lon),
        ).km
        restaurants_with_order_distance.append(
            {
                'restaurant': restaurant,
                'order_distance': round(distance_between_restoraunt_and_order, 2),
            }
        )
    return sorted(restaurants_with_order_distance, key=lambda restaurant: restaurant['order_distance'])
