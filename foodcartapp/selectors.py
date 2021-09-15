from typing import List

from geopy import distance

from foodcartapp.models import Order, RestaurantMenuItem
from location.models import Location


def get_restaurants_with_products_from_order(
    order: Order, products_in_restaurants: List[RestaurantMenuItem], locations,
):
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
        locations=locations,
    )


def get_location_coords(address: str, locations):
    coords = locations.get(address, False)
    if not coords:
        lon, lat = Location.fetch_coordinates(address)
        location, is_created = Location.objects.get_or_create(
            address=address,
            lat=lat,
            lon=lon,
        )
        return location.lat, location.lon
    return coords


def calculate_distances_to_order(restaurants, order_address: str, locations):
    order_lat, order_lon = get_location_coords(order_address, locations)

    restaurants_with_order_distance = []

    for restaurant in restaurants:
        restaurant_lat, restaurant_lon = get_location_coords(restaurant.address, locations)
        distance_between_restaurant_and_order = distance.distance(
            (order_lat, order_lon), (restaurant_lat, restaurant_lon),
        ).km
        restaurants_with_order_distance.append(
            {
                'restaurant': restaurant,
                'order_distance': round(distance_between_restaurant_and_order, 2),
            }
        )
    return sorted(restaurants_with_order_distance, key=lambda restaurant: restaurant['order_distance'])
