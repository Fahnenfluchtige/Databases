from django.shortcuts import render
from django.db import connection
import logging

logger = logging.getLogger(__name__)

from .models import Products, Fashion, IsHereForManager, showBasket, IsHereForUser, Health, ProductsWithCosmetics, \
ProductsWithGroomThings, Rig, Accesuars

def products(request):
    products_list = Products.objects.all()
    return render(request, 'products_list.html', {'products_list': products_list})


def ishereformanager(request):
    data = IsHereForManager.objects.all()
    return render(request, 'products_list.html', {'data': data})

def ishereforuser(request):
    data = IsHereForUser.objects.all()
    return render(request, 'products_list.html', {'data': data})


def showbasket(request):
    basket = showBasket.objects.all()
    return render(request, 'products_list.html', {'showbasket': basket})

def fashion(request):
    fashion = Fashion.objects.all()
    return render(request, 'products_list.html', {'fashion': fashion})

def health(request):
    health = Health.objects.all()
    return render(request, 'products_list.html', {'health': health})


def cosmetics(request):
    cosmetics = ProductsWithCosmetics.objects.all()
    return render(request, 'products_list.html', {'cosmetics': cosmetics})

def show_productswithgroomthings(request):
    products_with_groomthings = ProductsWithGroomThings.objects.all()
    return render(request, 'products_list.html', {'products_with_groomthings': products_with_groomthings})


def rig(request):
    rig = Rig.objects.all()
    return render(request, 'products_list.html', {'rig': rig})

def accesuars(request):
    accesuars = Accesuars.objects.all()
    return render(request, 'products_list.html', {'accesuars': accesuars})

def add_to_basket(request):
    if request.method == 'POST':
        product_id = request.POST.get('product_id')

        with connection.cursor() as cursor:
            cursor.execute('INSERT INTO basket (idProduct) VALUES (%s)', [product_id])

    return render(request, 'products_list.html')


def delete_from_basket(request):
    if request.method == 'POST':
        idbasket = request.POST.get('idbasket')

        with connection.cursor() as cursor:
            cursor.execute('SELECT * FROM deletefrombasket(%s)', [idbasket])
           

    return render(request, 'products_list.html')


def get_drug_info(request):
    with connection.cursor() as cursor:

        cursor.callproc('get_drug_info')
        drug_info = cursor.fetchone()
   
    return render(request, 'products_list.html', {'drug_info': drug_info})

def get_avg_drug_price(request):
    with connection.cursor() as cursor:
        cursor.callproc('get_avg_drug_price')
        average_price = cursor.fetchone()
    
    return render(request, 'products_list.html', {'average_price': average_price})
