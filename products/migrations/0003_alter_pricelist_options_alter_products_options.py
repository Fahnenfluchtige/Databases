# Generated by Django 4.2.7 on 2023-11-25 12:13

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('products', '0002_products_remove_pricelist_name_pricelist_price_and_more'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='pricelist',
            options={'managed': False},
        ),
        migrations.AlterModelOptions(
            name='products',
            options={'managed': False},
        ),
    ]