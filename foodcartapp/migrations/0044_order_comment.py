# Generated by Django 3.2.4 on 2021-09-07 08:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('foodcartapp', '0043_order_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='comment',
            field=models.TextField(blank=True, max_length=200, verbose_name='Комментарий'),
        ),
    ]