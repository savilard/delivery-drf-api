import pytest

from foodcartapp.models import Order, Product
from foodcartapp.services import save_order_to_db


@pytest.mark.django_db
def test_save_order_to_db():
    orders = Order.objects.all()
    assert len(orders) == 0

    burger = Product.objects.create(name='Бургер', price=199.00)
    big_burger = Product.objects.create(name='Большой бургер', price=399.00)

    validated_data = {
        'products':
            [
                {'product': burger, 'quantity': 1},
                {'product': big_burger, 'quantity': 2},
            ],
        'firstname': 'Иван',
        'lastname': 'Иванов',
        'phonenumber': '+77256522525',
        'address': 'Москва Арбат 5',
    }

    save_order_to_db(validated_data)

    orders = Order.objects.all()
    assert len(orders) == 1
