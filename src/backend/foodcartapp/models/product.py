from django.core.validators import MinValueValidator
from django.db import models

from foodcartapp.models.restaurant import RestaurantMenuItem


class ProductQuerySet(models.QuerySet):
    """Product model custom queryset."""

    def available(self):
        """Returns food that is in stock at the selected restaurant."""
        products = RestaurantMenuItem.objects.filter(availability=True).values_list('product')
        return self.filter(pk__in=products)


class ProductCategory(models.Model):
    """Product category model."""

    name = models.CharField(
        'название',
        max_length=50,
    )

    class Meta:
        verbose_name = 'категория'
        verbose_name_plural = 'категории'

    def __str__(self):
        return self.name


class Product(models.Model):
    """Product model."""

    name = models.CharField(
        'название',
        max_length=50,
    )
    category = models.ForeignKey(
        ProductCategory,
        verbose_name='категория',
        related_name='products',
        null=True,
        blank=True,
        on_delete=models.SET_NULL,
    )
    price = models.DecimalField(
        'цена',
        max_digits=8,
        decimal_places=2,
        validators=[MinValueValidator(0)],
    )
    image = models.ImageField('картинка')
    special_status = models.BooleanField(
        'спец.предложение',
        default=False,
        db_index=True,
    )
    description = models.TextField(
        'описание',
        max_length=200,
        blank=True,
    )

    objects = ProductQuerySet.as_manager()

    class Meta:
        verbose_name = 'товар'
        verbose_name_plural = 'товары'

    def __str__(self):
        return self.name
