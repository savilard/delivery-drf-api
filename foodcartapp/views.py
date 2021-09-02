from django.http import JsonResponse
from django.templatetags.static import static
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from .models import Product
from .services import save_order_to_db


def banners_list_api(request):
    # FIXME move data to db?
    return JsonResponse([
        {
            'title': 'Burger',
            'src': static('burger.jpg'),
            'text': 'Tasty Burger at your door step',
        },
        {
            'title': 'Spices',
            'src': static('food.jpg'),
            'text': 'All Cuisines',
        },
        {
            'title': 'New York',
            'src': static('tasty.jpg'),
            'text': 'Food is incomplete without a tasty dessert',
        }
    ], safe=False, json_dumps_params={
        'ensure_ascii': False,
        'indent': 4,
    })


@api_view(['GET'])
def product_list_api(request):
    products = Product.objects.select_related('category').available()

    dumped_products = []
    for product in products:
        dumped_product = {
            'id': product.id,
            'name': product.name,
            'price': product.price,
            'special_status': product.special_status,
            'description': product.description,
            'category': {
                'id': product.category.id,
                'name': product.category.name,
            },
            'image': product.image.url,
            'restaurant': {
                'id': product.id,
                'name': product.name,
            }
        }
        dumped_products.append(dumped_product)
    return Response(dumped_products)


@api_view(['POST'])
def register_order(request):
    order_content = request.data

    try:
        products = order_content['products']
    except KeyError:
        return Response(
            {'error': 'products: Обязательное поле'},
            status=status.HTTP_400_BAD_REQUEST,
        )

    if isinstance(products, str):
        return Response(
            {'error': 'products: Ожидался list со значениями, но был получен "str"'},
            status=status.HTTP_400_BAD_REQUEST,
        )
    elif products is None:
        return Response(
            {'error': 'products: Это поле не может быть пустым'},
            status=status.HTTP_400_BAD_REQUEST,
        )
    elif isinstance(products, list) and not products:
        return Response(
            {'error': 'products: Этот список не может быть пустым'},
            status=status.HTTP_400_BAD_REQUEST,
        )

    save_order_to_db(request.data)
    return JsonResponse({}, )
