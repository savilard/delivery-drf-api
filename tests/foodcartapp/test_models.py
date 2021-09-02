import pytest

from foodcartapp.models import Order, OrderProduct, Product


@pytest.mark.django_db
def test_order_model():
    """Tests saving the order to the database."""
    order = Order(firstname='Иван', lastname='Иванов', phonenumber='+77256522525', address='Москва Арбат 5')
    order.save()

    assert order.firstname == 'Иван'
    assert order.lastname == 'Иванов'
    assert order.address == 'Москва Арбат 5'
    assert str(order) == f'{order.firstname} {order.lastname}'


@pytest.mark.django_db
def test_order_product_model():
    order = Order.objects.create(
        firstname='Иван',
        lastname='Иванов',
        phonenumber='+77256522525',
        address='Москва Арбат 5',
    )

    product = Product.objects.create(
        name='Бургер',
        price=199.00,
    )

    OrderProduct.objects.create(
        order=order,
        product=product,
        quantity=1,
    )

    record = OrderProduct.objects.get(id=1)
    assert record.product.name == 'Бургер'
    assert record.order.firstname == 'Иван'
    assert record.quantity == 1
    assert str(record) == f'{record.product.name} {record.quantity}'

