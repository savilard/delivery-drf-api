from typing import NamedTuple, Optional

from django.conf import settings
from django.db import models
from django.utils import timezone

import requests


class LocationCoords(NamedTuple):
    """Location coords."""

    lat: float
    lon: float


class LocationManager(models.Manager):
    """Location custom manager."""

    def get_addresses_and_their_coordinates(self):
        """Get addresses and their coordinates."""
        return {
            location.address: LocationCoords(lat=location.lat, lon=location.lon)
            for location in self.all()
        }


class Location(models.Model):
    """Location model."""

    address = models.CharField('Адрес', max_length=150, unique=True)
    lat = models.FloatField('Широта', blank=True, null=True)
    lon = models.FloatField('Долгота', blank=True, null=True)
    created_at = models.DateTimeField('Дата создания', default=timezone.now)

    objects = LocationManager()

    class Meta:
        verbose_name = 'локация'
        verbose_name_plural = 'локации'

    def __str__(self):
        return self.address

    @staticmethod
    def fetch_coordinates(location_address: str) -> Optional[LocationCoords]:
        """Gets the coordinates of the place using Yandex Geocoder Api.

        Args:
            location_address: location address
        Returns:
            LocationCoords: longitude and latitude of the place
        """
        base_url = 'https://geocode-maps.yandex.ru/1.x'
        payload = {
            'geocode': location_address,
            'apikey': settings.YANDEX_GEOCODER_APIKEY,
            'format': 'json',
        }
        response = requests.get(base_url, params=payload)
        response.raise_for_status()
        places_found = response.json()['response']['GeoObjectCollection']['featureMember']
        if not places_found:
            return None
        lon, lat = places_found[0]['GeoObject']['Point']['pos'].split(' ')
        return LocationCoords(lat=lat, lon=lon)
