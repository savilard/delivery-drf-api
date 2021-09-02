import pytest

from foodcartapp.models import Order, Product
from foodcartapp.services import save_order_to_db


@pytest.mark.django_db
def test_save_order_to_db():
    orders = Order.objects.all()
    assert len(orders) == 0

    Product.objects.create(name='Бургер', price=199.00)
    Product.objects.create(name='Бургер', price=199.00)
    Product.objects.create(name='Бургер', price=199.00)

    validated_data = {
        'products':
            [
                {'product': 1, 'quantity': 1},
                {'product': 2, 'quantity': 1},
                {'product': 3, 'quantity': 1}
            ],
        'firstname': 'Иван',
        'lastname': 'Иванов',
        'phonenumber': '+77256522525',
        'address': 'Москва Арбат 5',
    }

    save_order_to_db(validated_data)

    orders = Order.objects.all()
    assert len(orders) == 1
