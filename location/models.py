from typing import Tuple

import requests
from django.db import models
from django.utils import timezone

from django.conf import settings


class Location(models.Model):
    address = models.CharField('Адрес', max_length=150, unique=True)
    lat = models.FloatField('Широта', blank=True, null=True)
    lon = models.FloatField('Долгота', blank=True, null=True)
    created_at = models.DateTimeField('Дата создания', default=timezone.now)

    class Meta:
        verbose_name = 'локация'
        verbose_name_plural = 'локации'

    def __str__(self):
        return self.address

    @staticmethod
    def fetch_coordinates(place) -> Tuple[float]:
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
            'apikey': settings.YANDEX_GEOCODER_APIKEY,
            'format': 'json',
        }
        response = requests.get(base_url, params=payload)
        response.raise_for_status()
        places_found = response.json()['response']['GeoObjectCollection']['featureMember']
        most_relevant = places_found[0]
        return most_relevant['GeoObject']['Point']['pos'].split(' ')
