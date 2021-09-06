# Generated by Django 3.2.4 on 2021-09-06 08:23

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('foodcartapp', '0040_auto_20210906_0452'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderproduct',
            name='cost',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=8, null=True, validators=[django.core.validators.MinValueValidator(0)], verbose_name='Стоимость'),
        ),
    ]
