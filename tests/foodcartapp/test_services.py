import pytest

from foodcartapp.models import Order
from foodcartapp.services import save_order_to_db


@pytest.mark.django_db
def test_save_order_to_db():
    orders = Order.objects.all()
    assert len(orders) == 0

    validated_data = {
        'firstname': 'Иван',
        'lastname': 'Иванов',
        'phonenumber': '+77256522525',
        'address': 'Москва Арбат 5',
    }

    save_order_to_db(validated_data)

    orders = Order.objects.all()
    assert len(orders) == 1
