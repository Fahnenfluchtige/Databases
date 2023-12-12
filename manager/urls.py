from django.urls import path
from . import views

urlpatterns = [
    path('', views.manager_page, name='manager_page'),
    path('insert_product/', views.insert_product, name='insert_product'),
   path('delete_product/', views.delete_product, name='delete_product'),
   path('update_product/', views.update_product, name='update_product'),
]
