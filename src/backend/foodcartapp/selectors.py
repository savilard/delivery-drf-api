from typing import Iterator, NamedTuple

from geopy import distance

from foodcartapp.models import Order
from foodcartapp.models import Restaurant
from foodcartapp.models import RestaurantMenuItem
from location.selectors import get_location_coords


class OrderCoords(NamedTuple):
    lat: float
    lon: float


class RestaurantCoords(NamedTuple):
    lat: float
    lon: float


def get_restaurants_with_products_from_order(
    order: Order,
    products_in_restaurants: Iterator[RestaurantMenuItem],
):
    """Get restaurants with products from order."""
    order_products = order.order_products.all()
    restaurants_with_products_from_order = []

    for order_product in order_products:
        restaurants_with_products_from_order.append(
            [
                (
                    product_in_restaurants.restaurant,
                    RestaurantCoords(
                        lat=product_in_restaurants.restaurant_lat,
                        lon=product_in_restaurants.restaurant_lon,
                    ),
                )
                for product_in_restaurants in products_in_restaurants
                if product_in_restaurants.product == order_product.product
            ],
        )

    return _calculate_distances_to_order(
        restaurants=set.intersection(*map(set, restaurants_with_products_from_order)),
        order=order,
        order_location=OrderCoords(
            lat=order.lat,
            lon=order.lon,
        ),
    )


def _calculate_distance_between_restaurant_and_order(order_coords, restaurant_coords):
    """Get distance between restaurant and order."""
    if order_coords is None or restaurant_coords is None:
        return 0
    return distance.distance(  # noqa: WPS317
        (order_coords.lat, order_coords.lon),
        (restaurant_coords.lat, restaurant_coords.lon),
    ).km


def _get_restaurant_with_order_distance(
    order: Order,
    restaurant: Restaurant,
    order_location: OrderCoords,
    restaurant_location: RestaurantCoords,
):
    """Get restaurant with order distance."""
    order_coords = get_location_coords(
        address=order.address,
        lat=order_location.lat,
        lon=order_location.lon,
    )

    restaurant_coords = get_location_coords(
        address=restaurant.address,
        lat=restaurant_location.lat,
        lon=restaurant_location.lon,
    )
    distance_between_restaurant_and_order = _calculate_distance_between_restaurant_and_order(
        order_coords=order_coords,
        restaurant_coords=restaurant_coords,
    )
    return {
        'restaurant': restaurant,
        'order_distance': round(distance_between_restaurant_and_order, 2),
    }


def _calculate_distances_to_order(restaurants, order: Order, order_location: OrderCoords):
    """Calculate distances to order."""
    restaurants_with_order_distance = [
        _get_restaurant_with_order_distance(
            order=order,
            order_location=order_location,
            restaurant=restaurant,
            restaurant_location=restaurant_location,
        )
        for restaurant, restaurant_location in restaurants
    ]

    return sorted(
        restaurants_with_order_distance,
        key=lambda restaurant: restaurant['order_distance'],  # noqa: WPS440, WPS441
    )
