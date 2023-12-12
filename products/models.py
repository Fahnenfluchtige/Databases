from django.db import models

class Products(models.Model):
    class Meta:
        managed = False
        db_table = 'products'

    idproducts = models.AutoField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    color = models.CharField(max_length=50)
    material = models.CharField(max_length=50)

class PriceList(models.Model):
    class Meta:
        managed = False
        db_table = 'pricelist'

    idpricelist = models.AutoField(primary_key=True)
    idproducts = models.ForeignKey('products', on_delete=models.CASCADE) 
    price = models.FloatField() 
    status = models.CharField(max_length=50)  

class BreedOfDog(models.Model):
    class Meta:
        managed = False
        db_table = 'breedofdog'

    idbreed = models.AutoField(primary_key=True)
    breedname = models.CharField(max_length=255)
    size = models.CharField(max_length=50)

class Health(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    htype = models.CharField(max_length=50) 
    price = models.FloatField()
    status = models.CharField(max_length=50)  

    class Meta:
        managed = False
        db_table = 'health'



class ProductsWithCosmetics(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    color = models.CharField(max_length=50)
    material = models.CharField(max_length=50)
    cosmetictype = models.CharField(max_length=50)
    price = models.FloatField()


    class Meta:
        managed = False
        db_table = 'productswithcosmetics'

class ProductsWithGroomThings(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    color = models.CharField(max_length=50)
    material = models.CharField(max_length=50)
    groomthingtype = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'productswithgroomthings'

class Rig(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    htype = models.CharField(max_length=50) 
    subtype = models.CharField(max_length=50) 
    price = models.FloatField()
    status = models.CharField(max_length=50)  

    class Meta:
        managed = False
        db_table = 'rig'

class Accesuars(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    htype = models.CharField(max_length=50) 
    subtype = models.CharField(max_length=50) 
    price = models.FloatField()

    class Meta:
        managed = False
        db_table = 'accesuars'



class Fashion(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    forsize = models.CharField(max_length=50)
    fashiontype = models.CharField(max_length=50)
    price = models.FloatField()
    status = models.CharField(max_length=50)

    class Meta:
        managed = False
        db_table = 'fashion'

class IsHereForManager(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    price = models.FloatField()
    status = models.CharField(max_length=50)
    producttype = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'ishereformanager'

class IsHereForUser(models.Model):
    idproducts = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    price = models.FloatField()
    status = models.CharField(max_length=50)
    producttype = models.CharField(max_length=255)

    class Meta:
        managed = False
        db_table = 'ishereforuser'



class showBasket(models.Model):
    idbasket = models.IntegerField(primary_key=True)
    productname = models.CharField(max_length=255)
    price = models.FloatField()
    class Meta:
        managed = False
        db_table = 'showbasket'


