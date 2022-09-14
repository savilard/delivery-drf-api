from rest_framework.serializers import ModelSerializer

from foodcartapp.models.order import OrderProduct, Order


class OrderProductSerializer(ModelSerializer):
    class Meta:
        model = OrderProduct
        fields = ['id', 'product', 'quantity']


class OrderSerializer(ModelSerializer):
    products = OrderProductSerializer(many=True, allow_empty=False, write_only=True)

    class Meta:
        model = Order
        fields = ['id', 'products', 'firstname', 'lastname', 'phonenumber', 'address']
