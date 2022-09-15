from django.contrib.auth import authenticate
from django.contrib.auth import login
from django.contrib.auth import views as auth_views
from django.shortcuts import redirect
from django.shortcuts import render
from django.urls import reverse_lazy
from django.views import View

from restaurateur.forms import Login


class LoginView(View):
    """Login view."""

    def get(self, request, *args, **kwargs):
        """Show login form."""
        form = Login()
        return render(request, 'login.html', context={'form': form})

    def post(self, request):
        """Login lo manager admin panel."""
        form = Login(request.POST)

        if form.is_valid():
            username = form.cleaned_data['username']
            password = form.cleaned_data['password']

            user = authenticate(request, username=username, password=password)
            if user:
                login(request, user)
                if user.is_staff:
                    return redirect('restaurateur:RestaurantView')
                return redirect('start_page')

        return render(
            request,
            'login.html',
            context={
                'form': form,
                'ivalid': True,
            },
        )


class LogoutView(auth_views.LogoutView):
    """Logout from manager admin panel."""

    next_page = reverse_lazy('restaurateur:login')
