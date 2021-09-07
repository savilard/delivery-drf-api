# Generated by Django 3.2.4 on 2021-09-06 10:01

from django.db import migrations


def save_order_cost_to_db(apps, schema_editor):
    Order = apps.get_model('foodcartapp', 'Order')

    orders = Order.objects.all().iterator()
    for order in orders:
        order_products = order.order_products.all().iterator()
        for order_product in order_products:
            order_product.cost = order_product.quantity * order_product.product.price
            order_product.save()


class Migration(migrations.Migration):

    dependencies = [
        ('foodcartapp', '0041_orderproduct_cost'),
    ]

    operations = [
        migrations.RunPython(save_order_cost_to_db),
    ]