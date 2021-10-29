# Generated by Django 3.2.4 on 2021-10-29 11:28

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('foodcartapp', '0049_alter_orderproduct_cost'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='payment_method',
            field=models.CharField(choices=[('cash', 'Наличные'), ('card', 'Карта'), ('not_selected', 'Не выбрано')], db_index=True, default='not_selected', max_length=15, verbose_name='Способ оплаты'),
        ),
    ]
