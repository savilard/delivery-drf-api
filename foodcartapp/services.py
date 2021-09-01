from foodcartapp.models import Order


def save_order_to_db(validated_data):
    """Creates valid data received from the frontend into the database."""
    order = Order.objects.create(
        firstname=validated_data['firstname'],
        lastname=validated_data['lastname'],
        phonenumber=validated_data['phonenumber'],
        address=validated_data['address'],
    )
    order.save()

    return order
