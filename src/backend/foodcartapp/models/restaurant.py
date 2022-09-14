from django.db import models

from location.models import Location


class RestaurantMenuItemQuerySet(models.QuerySet):
    """Restaurant menu item custom queryset."""

    def with_restaurant_coords_from_cache(self):
        """Get the coordinates of the restaurant from the location table."""
        location = Location.objects.filter(address=models.OuterRef('restaurant__address'))
        return self.annotate(
            restaurant_lat=models.Subquery(
                queryset=location.values('lat'),
                output_field=models.FloatField(),
            ),
            restaurant_lon=models.Subquery(
                queryset=location.values('lon'),
                output_field=models.FloatField(),
            ),
        )


class Restaurant(models.Model):
    """Restaurant model."""

    name = models.CharField(
        'название',
        max_length=50,
    )
    address = models.CharField(
        'адрес',
        max_length=100,
        blank=True,
    )
    contact_phone = models.CharField(
        'контактный телефон',
        max_length=50,
        blank=True,
    )

    class Meta:
        verbose_name = 'ресторан'
        verbose_name_plural = 'рестораны'

    def __str__(self):
        return self.name


class RestaurantMenuItem(models.Model):
    """Restaurant menu item model."""

    restaurant = models.ForeignKey(
        Restaurant,
        related_name='menu_items',
        verbose_name='ресторан',
        on_delete=models.CASCADE,
    )
    product = models.ForeignKey(
        'Product',
        on_delete=models.CASCADE,
        related_name='menu_items',
        verbose_name='продукт',
    )
    availability = models.BooleanField(
        verbose_name='в продаже',
        default=True,
        db_index=True,
    )

    objects = RestaurantMenuItemQuerySet.as_manager()

    class Meta:
        verbose_name = 'пункт меню ресторана'
        verbose_name_plural = 'пункты меню ресторана'
        unique_together = [
            ['restaurant', 'product'],
        ]

    def __str__(self):
        return f'{self.restaurant.name} - {self.product.name}'
