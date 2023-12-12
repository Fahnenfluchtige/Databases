from django.shortcuts import render
from .forms import InsertProductForm, DeleteProductForm, UpdateProductForm
from django.db import connection

def manager_page(request):
    insert_form = InsertProductForm()
    delete_form = DeleteProductForm()
    update_form = UpdateProductForm()

    return render(request, 'manager_page.html', {
        'insert_form': insert_form,
        'delete_form': delete_form,
        'update_form': update_form,
    })

def insert_product(request):
    product_name = request.POST.get('product_name')
    for_size = request.POST.get('for_size')
    color = request.POST.get('color')
    material = request.POST.get('material')
    price = request.POST.get('price')
    status = request.POST.get('status')
    drug_type = request.POST.get('drug_type', default=None)
    vitamin_type = request.POST.get('vitamin_type', default=None)
    cosmetic_type = request.POST.get('cosmetic_type', default=None)
    clothes_type = request.POST.get('clothes_type', default=None)
    groom_thing_type = request.POST.get('groom_thing_type', default=None)
    boots_type = request.POST.get('boots_type', default=None)
    collars_type = request.POST.get('collars_type', default=None)
    harness_type = request.POST.get('harness_type', default=None)
    toy_type = request.POST.get('toy_type', default=None)
    bowl_pattern = request.POST.get('bowl_pattern', default=None)

    with connection.cursor() as cursor:
          cursor.execute('CALL insertproduct(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
            product_name,
            for_size,
            color,
            material,
            price,
            status,
            drug_type,
            vitamin_type,
            cosmetic_type,
            clothes_type,
            groom_thing_type,
            boots_type,
            collars_type,
            harness_type,
            toy_type,
            bowl_pattern,
        ])

    return render(request, 'products_list.html')

def delete_product(request):
    product_id = request.POST.get('product_id')
    with connection.cursor() as cursor:
        cursor.execute('CALL deleteproduct(%s)', [product_id])

    return render(request, 'products_list.html')

def update_product(request):
    product_id = request.POST.get('product_id')
    product_name = request.POST.get('product_name')
    with connection.cursor() as cursor:
        cursor.execute('CALL updateproduct(%s, %s)', [product_id, product_name])

    return render(request, 'products_list.html')
