from foodcartapp.models import Order


def serialize_order(order: Order, restaurants):
    """Serialize order."""
    return {
        'id': order.id,
        'status': order.get_status_display,
        'payment_method': order.get_payment_method_display,
        'order_amount': order.order_amount,
        'firstname': order.firstname,
        'lastname': order.lastname,
        'phonenumber': order.phonenumber,
        'address': order.address,
        'comment': order.comment,
        'restaurants': restaurants,
    }
