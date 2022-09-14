from django.core.validators import MaxValueValidator
from django.core.validators import MinValueValidator
from django.db import models
from django.utils import timezone

from phonenumber_field.modelfields import PhoneNumberField

from location.models import Location


class OrderQuerySet(models.QuerySet):
    """Order model custom queryset."""

    def calculate_order_amount(self):
        """Calculates the total amount of the order."""
        return self.annotate(
            order_amount=models.Sum(
                models.F('order_products__cost'),
                output_field=models.DecimalField(),
            ),
        )

    def only_unprocessed(self):
        """Returns only unprocessed orders."""
        return self.calculate_order_amount().exclude(status='processed')

    def with_coords_from_cache(self):
        """Get the coordinates from the location table."""
        location = Location.objects.filter(address=models.OuterRef('address'))
        return self.annotate(
            lat=models.Subquery(
                queryset=location.values('lat'),
                output_field=models.FloatField(),
            ),
            lon=models.Subquery(
                queryset=location.values('lon'),
                output_field=models.FloatField(),
            ),
        )


class Order(models.Model):
    """Order model."""

    PROCESSED = 'processed'
    UNPROCESSED = 'unprocessed'
    ORDER_STATUS_CHOICES = [
        (PROCESSED, 'Обработанный'),
        (UNPROCESSED, 'Необработанный'),
    ]

    CASH = 'cash'
    CARD = 'card'
    NOT_SELECTED = 'not_selected'
    PAYMENT_METHOD_CHOICES = [
        (CASH, 'Наличные'),
        (CARD, 'Карта'),
        (NOT_SELECTED, 'Не выбрано'),
    ]

    firstname = models.CharField('Имя', max_length=20)
    lastname = models.CharField('Фамилия', max_length=20)
    phonenumber = PhoneNumberField('Номер телефона', max_length=15, db_index=True)
    address = models.CharField('Адрес доставки', max_length=200, db_index=True)
    status = models.CharField(
        'Статус',
        choices=ORDER_STATUS_CHOICES,
        default=UNPROCESSED,
        max_length=11,
        db_index=True,
    )
    comment = models.TextField('Комментарий', max_length=200, blank=True)
    registrated_at = models.DateTimeField('Дата регистрации', default=timezone.now, db_index=True)
    called_at = models.DateTimeField('Дата звонка', null=True, blank=True, db_index=True)
    delivered_at = models.DateTimeField('Дата доставки', null=True, blank=True, db_index=True)
    payment_method = models.CharField(
        'Способ оплаты',
        choices=PAYMENT_METHOD_CHOICES,
        default=NOT_SELECTED,
        max_length=15,
        db_index=True,
    )

    restaurant = models.ForeignKey(
        'Restaurant',
        on_delete=models.SET_NULL,
        verbose_name='Забрать в ресторане',
        related_name='orders',
        null=True,
        blank=True,
    )

    objects = OrderQuerySet.as_manager()

    class Meta:
        verbose_name = 'заказ'
        verbose_name_plural = 'заказы'

    def __str__(self):
        return f'{self.firstname} {self.lastname}'


class OrderProduct(models.Model):
    """Order product model."""

    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        verbose_name='Заказ',
        related_name='order_products',
    )

    product = models.ForeignKey(
        'Product',
        on_delete=models.CASCADE,
        verbose_name='Продукт',
        related_name='order_products',
    )

    quantity = models.PositiveIntegerField('Количество', validators=[MaxValueValidator(50)])
    cost = models.DecimalField(
        'Стоимость',
        max_digits=8,
        decimal_places=2,
        validators=[MinValueValidator(0)],
    )

    class Meta:
        verbose_name = 'товар в заказе'
        verbose_name_plural = 'товары в заказе'

    def __str__(self):
        return f'{self.product.name} {self.quantity}'
