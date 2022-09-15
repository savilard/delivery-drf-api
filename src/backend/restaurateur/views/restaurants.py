from django.contrib.auth.decorators import user_passes_test
from django.shortcuts import render

from core.helpers import is_manager
from foodcartapp.models import Restaurant


@user_passes_test(is_manager, login_url='restaurateur:login')
def view_restaurants(request):
    """Shows restaurants in the manager's admin panel."""
    return render(
        request,
        template_name='restaurants_list.html',
        context={
            'restaurants': Restaurant.objects.all(),
        },
    )
