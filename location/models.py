from django.db import models
from django.utils import timezone


class Location(models.Model):
    address = models.CharField('Адрес', max_length=150, unique=True)
    lat = models.FloatField('Широта', blank=True, null=True)
    lon = models.FloatField('Долгота', blank=True, null=True)
    created_at = models.DateTimeField('Дата создания', default=timezone.now)

    class Meta:
        verbose_name = 'локация'
        verbose_name_plural = 'локации'

    def __str__(self):
        return self.address
