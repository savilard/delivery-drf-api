from foodcartapp.models import Order
from foodcartapp.models import OrderProduct


def save_order_to_db(validated_data):
    """Creates valid data received from the frontend into the database."""
    order = Order.objects.create(
        firstname=validated_data['firstname'],
        lastname=validated_data['lastname'],
        phonenumber=validated_data['phonenumber'],
        address=validated_data['address'],
    )

    validated_products = validated_data['products']

    OrderProduct.objects.bulk_create(
        [
            OrderProduct(
                order=order,
                cost=validated_product['quantity'] * validated_product['product'].price,
                **validated_product,
            )
            for validated_product in validated_products
        ],
    )

    return order
