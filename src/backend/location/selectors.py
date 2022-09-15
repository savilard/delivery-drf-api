from typing import Optional

from location.models import Location
from location.models import LocationCoords


def get_location_coords(
    address: str,
    lat: Optional[float],
    lon: Optional[float],
) -> Optional[LocationCoords]:
    """Get location coords."""
    if lat is not None and lon is not None:
        return LocationCoords(lat=lat, lon=lon)

    coords = Location.fetch_coordinates(address)
    if coords is None:
        return None

    location, is_created = Location.objects.get_or_create(
        address=address,
        lat=coords.lat,
        lon=coords.lon,
    )
    return LocationCoords(lat=location.lat, lon=location.lon)
