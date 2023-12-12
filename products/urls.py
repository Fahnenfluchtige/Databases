from django.urls import path
from . import views

urlpatterns = [
    path('', views.products, name='products_list'),
    path('fashion/', views.fashion, name='fashion'),
    path('ishereformanager/', views.ishereformanager, name='ishereformanager'),
    path('ishereforuser/', views.ishereforuser, name='ishereforuser'),
    path('showbasket/', views.showbasket, name='showbasket'),
    path('productswithgroomthings/', views.show_productswithgroomthings, name='productswithgroomthings'),
    path('health/', views.health, name='health'),
    path('cosmetics/', views.cosmetics, name='cosmetics'),
    path('rig/', views.rig, name='rig'),
    path('accesuars/', views.accesuars, name='accesuars'),
    path('add_to_basket/', views.add_to_basket, name='add_to_basket'),
    path('delete_from_basket/', views.delete_from_basket, name='delete_from_basket'),
    path('get_drug_info/', views.get_drug_info, name='get_drug_info'),
    path('get_avg_drug_price/', views.get_avg_drug_price, name='get_avg_drug_price'),

 ]