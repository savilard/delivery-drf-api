import pytest

from foodcartapp.models import Order


@pytest.mark.django_db
def test_order_model():
    """Tests saving the order to the database."""
    order = Order(firstname='Иван', lastname='Иванов', phonenumber='+77256522525', address='Москва Арбат 5')
    order.save()

    assert order.firstname == 'Иван'
    assert order.lastname == 'Иванов'
    assert order.address == 'Москва Арбат 5'
    assert str(order) == f'{order.firstname} {order.lastname}'
