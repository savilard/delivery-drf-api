from django.urls import path

from foodcartapp import views

app_name = 'foodcartapp'

urlpatterns = [
    path('products/', views.product_list_api),
    path('banners/', views.banners_list_api),
    path('order/', views.register_order),
]
