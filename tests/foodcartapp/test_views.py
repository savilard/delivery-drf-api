import pytest

from foodcartapp.models import Order


@pytest.mark.django_db
@pytest.mark.parametrize(
    'order_content, error_message',
    [
        (
            {"products": "HelloWorld", "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
            'products: Ожидался list со значениями, но был получен "str"',
        ),
        (
            {"products": None, "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
            'products: Это поле не может быть пустым',
        ),
        (
            {"products": [], "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
            'products: Этот список не может быть пустым',
        ),
        (
            {"firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000", "address": "Москва"},
            'products: Обязательное поле',
        )
    ]
)
def test_invalid_data_validation_for_register_order(client, order_content, error_message):
    orders = Order.objects.all()
    assert len(orders) == 0

    response = client.post('/api/order/', order_content, content_type="application/json")

    assert response.status_code == 400
    assert response.data['error'] == error_message

    movies = Order.objects.all()
    assert len(movies) == 0
