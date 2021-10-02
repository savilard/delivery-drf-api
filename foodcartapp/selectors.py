from typing import Optional

from geopy import distance

from location.models import Location, LocationCoords


def get_restaurants_with_products_from_order(order, products_in_restaurants):
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
        order_lat=order.lat,
        order_lon=order.lon,
    )


def get_location_coords(
    address: str, lat: Optional[float] = None, lon: Optional[float] = None,
) -> Optional[LocationCoords]:
    if lat is not None and lon is not None:
        return LocationCoords(lat=lat, lon=lon)
    else:
        coords = Location.fetch_coordinates(address)
        if coords is None:
            return None

        location, is_created = Location.objects.get_or_create(
            address=address,
            lat=coords.lat,
            lon=coords.lon,
        )
        return LocationCoords(lat=location.lat, lon=location.lon)


def calculate_distances_to_order(restaurants, order_address: str, order_lat, order_lon):
    order_coords = get_location_coords(order_address, order_lat, order_lon)

    restaurants_with_order_distance = []

    for restaurant in restaurants:
        restaurant_coords = get_location_coords(restaurant.address)

        if order_coords is None or restaurant_coords is None:
            distance_between_restaurant_and_order = 0
        else:
            distance_between_restaurant_and_order = distance.distance(
                (order_coords.lat, order_coords.lon),
                (restaurant_coords.lat, restaurant_coords.lon),
            ).km

        restaurants_with_order_distance.append(
            {
                'restaurant': restaurant,
                'order_distance': round(distance_between_restaurant_and_order, 2),
            }
        )
    return sorted(restaurants_with_order_distance, key=lambda restaurant: restaurant['order_distance'])
