import pytest

from foodcartapp.models import Order


@pytest.mark.django_db
@pytest.mark.parametrize(
    'order_content',
    [
        (
            {"products": "HelloWorld", "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
        ),
        (
            {"products": None, "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
        ),
        (
            {"products": [], "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
        ),
        ({"firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000", "address": "Москва"}),
        (
            {"products": [{"product": 1, "quantity": 1}], "firstname": None, "lastname": "Петров",
             "phonenumber": "+79291000000", "address": "Москва"},
        ),
        ({"products": [{"product": 1, "quantity": 1}]}),
        (
            {"products": [], "firstname": "Иван", "lastname": "Петров", "phonenumber": "+79291000000",
             "address": "Москва"},
        ),
        (
            {"products": [{"product": 1, "quantity": 1}], "firstname": None, "lastname": None, "phonenumber": None,
             "address": None},
        ),
        (
            {"products": [{"product": 1, "quantity": 1}], "firstname": "Тимур", "lastname": "Иванов", "phonenumber": "",
             "address": "Москва, Новый Арбат 10"},
        ),
        (
            {"products": [{"product": 1, "quantity": 1}], "firstname": "Тимур", "lastname": "Иванов",
             "phonenumber": "+70000000000", "address": "Москва, Новый Арбат 10"},
        ),
        (
            {"products": [{"product": 9999, "quantity": 1}], "firstname": "Иван", "lastname": "Петров",
             "phonenumber": "+79291000000", "address": "Москва"},
        ),
        (
            {"products": [{"product": 1, "quantity": 1}], "firstname": [], "lastname": "Петров",
             "phonenumber": "+79291000000", "address": "Москва"},
        ),
    ]
)
def test_invalid_data_validation_for_register_order(client, order_content):
    orders = Order.objects.all()
    assert len(orders) == 0

    response = client.post('/api/order/', order_content, content_type="application/json")

    assert response.status_code == 400

    movies = Order.objects.all()
    assert len(movies) == 0
