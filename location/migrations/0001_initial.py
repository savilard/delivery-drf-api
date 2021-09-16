# Generated by Django 3.2.4 on 2021-09-10 09:52

from django.db import migrations, models
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Location',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address', models.CharField(max_length=150, unique=True, verbose_name='Адрес')),
                ('lat', models.FloatField(blank=True, null=True, verbose_name='Широта')),
                ('lon', models.FloatField(blank=True, null=True, verbose_name='Долгота')),
                ('created_at', models.DateTimeField(default=django.utils.timezone.now, verbose_name='Дата создания')),
            ],
            options={
                'verbose_name': 'локация',
                'verbose_name_plural': 'локации',
            },
        ),
    ]