from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models
from django.db.models import Subquery, OuterRef
from django.utils import timezone
from phonenumber_field.modelfields import PhoneNumberField

from location.models import Location


class Restaurant(models.Model):
    name = models.CharField(
        'название',
        max_length=50
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


class ProductQuerySet(models.QuerySet):
    def available(self):
        products = (
            RestaurantMenuItem.objects
                .filter(availability=True)
                .values_list('product')
        )
        return self.filter(pk__in=products)


class ProductCategory(models.Model):
    name = models.CharField(
        'название',
        max_length=50
    )

    class Meta:
        verbose_name = 'категория'
        verbose_name_plural = 'категории'

    def __str__(self):
        return self.name


class Product(models.Model):
    name = models.CharField(
        'название',
        max_length=50
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
        validators=[MinValueValidator(0)]
    )
    image = models.ImageField(
        'картинка'
    )
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


class RestaurantMenuItemQuerySet(models.QuerySet):
    def with_restaurant_coords_from_cache(self):
        location = Location.objects.filter(address=OuterRef('restaurant__address'))
        return self.annotate(
            restaurant_lat=Subquery(
                queryset=location.values('lat'),
                output_field=models.FloatField(),
            ),
            restaurant_lon=Subquery(
                queryset=location.values('lon'),
                output_field=models.FloatField(),
            ),
        )


class RestaurantMenuItem(models.Model):
    restaurant = models.ForeignKey(
        Restaurant,
        related_name='menu_items',
        verbose_name="ресторан",
        on_delete=models.CASCADE,
    )
    product = models.ForeignKey(
        Product,
        on_delete=models.CASCADE,
        related_name='menu_items',
        verbose_name='продукт',
    )
    availability = models.BooleanField(
        'в продаже',
        default=True,
        db_index=True
    )

    objects = RestaurantMenuItemQuerySet.as_manager()

    class Meta:
        verbose_name = 'пункт меню ресторана'
        verbose_name_plural = 'пункты меню ресторана'
        unique_together = [
            ['restaurant', 'product']
        ]

    def __str__(self):
        return f"{self.restaurant.name} - {self.product.name}"


class OrderQuerySet(models.QuerySet):
    def calculate_order_amount(self):
        return self.annotate(
            order_amount=models.Sum(
                models.F('order_products__cost'),
                output_field=models.DecimalField(),
            )
        )

    def only_unprocessed(self):
        return self.calculate_order_amount().exclude(status='processed')

    def with_coords_from_cache(self):
        location = Location.objects.filter(address=OuterRef('address'))
        return self.annotate(
            lat=Subquery(
                queryset=location.values('lat'),
                output_field=models.FloatField(),
            ),
            lon=Subquery(
                queryset=location.values('lon'),
                output_field=models.FloatField(),
            ),
        )


class Order(models.Model):
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
        Restaurant,
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
    order = models.ForeignKey(
        Order,
        on_delete=models.CASCADE,
        verbose_name='Заказ',
        related_name='order_products',
    )

    product = models.ForeignKey(
        Product,
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
