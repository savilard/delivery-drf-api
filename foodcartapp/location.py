from typing import Tuple

import requests


def fetch_coordinates(apikey: str, place: str) -> Tuple[float]:
    """Gets the coordinates of the place using Yandex Geocoder Api.
    Args:
        apikey (str): apikey of Yandex Geocoder Api
        place (srt): name of the place
    Returns:
        tuple: longitude and latitude of the place in the format (lon, lat)
    """
    base_url = 'https://geocode-maps.yandex.ru/1.x'
    payload = {
        'geocode': place,
        'apikey': apikey,
        'format': 'json',
    }
    response = requests.get(base_url, params=payload)
    response.raise_for_status()
    places_found = response.json()['response']['GeoObjectCollection']['featureMember']
    most_relevant = places_found[0]
    return most_relevant['GeoObject']['Point']['pos'].split(' ')
