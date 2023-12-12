from django import forms

class InsertProductForm(forms.Form):
    product_name = forms.CharField(max_length=255)
    for_size = forms.CharField(max_length=50)
    color = forms.CharField(max_length=50, required=False)
    material = forms.CharField(max_length=50,  required=False)
    price = forms.FloatField()
    status = forms.CharField(max_length=50)
    bowl_pattern = forms.ChoiceField(choices=[  ('без рисунка', 'без рисунка'),
                                             ('рисунок косточка', 'рисунок косточка'),
                                          ('рисунок лапка', 'рисунок лапка'),
                                                 ('красная', 'красная'),
                                                    ('синяя', 'синяя'),
                                                    ('фиолетовая', 'фиолетовая'),
    ], required=False)
    drugs_type = forms.ChoiceField(choices=[ ('лекарства для ушек', 'лекарства для ушек'),
                                            ('капли для глаз', 'капли для глаз'),
                                            ('таблетки от блох', 'таблетки от блох'),
                                            ('таблетки от гельминтов', 'таблетки от гельминтов'),
                                            ('таблетки от паразитов', 'таблетки от паразитов'),
    ], required=False)
    
    vitamins_type = forms.ChoiceField(choices=[ ('содержащие кальций', 'содержащие кальций'),
                                                ('для обогащения рациона', 'для обогащения рациона'),
                                                ('для поддержания здоровья шерсти', 'для поддержания здоровья шерсти'),
    ], required=False)
    cosmetics_type = forms.ChoiceField(choices=[  ('шампунь', 'шампунь'),
                                                    ('бальзамы', 'бальзамы'),
                                                    ('маски для шерсти', 'маски для шерсти'),
                                                    ('масла для лапок', 'масла для лапок'),
    ], required=False)
    groom_things_type = forms.ChoiceField(choices=[ ('когтерез', 'когтерез'),
                                                    ('пуходерка', 'пуходерка'),
                                                    ('фурминатор', 'фурминатор'),
                                                   
    ], required=False)
    clothes_type = forms.ChoiceField(choices=[('праздничная', 'праздничная'),
                                                ('выставочная', 'выставочная'),
                                                ('лето', 'лето'),
                                                ('зима', 'зима'),
                                                ('осень-весна', 'осень-весна'),
    ], required=False)
    boots_type = forms.ChoiceField(choices=[ ('праздничные', 'праздничные'),
                                            ('выставочные', 'выставочные'),
                                            ('зима', 'зима'),
                                            ('осень-весна', 'осень-весна'),
                                            ('домашние', 'домашние'),
    ], required=False)
    collars_type = forms.ChoiceField(choices=[('красный кожанный ошейник с шипами', 'красный кожанный ошейник с шипами'),
                                               ('черный кожаный ошейник', 'черный кожаный ошейник')], required=False)
    harness_type = forms.ChoiceField(choices=[('красный', 'красные'), 
                                              ('синий', 'синие')], required=False)

    toys_type = forms.CharField(max_length=50, required=False)

class DeleteProductForm(forms.Form):
    product_id = forms.IntegerField()

class UpdateProductForm(forms.Form):
    product_id = forms.IntegerField()
    product_name = forms.CharField(max_length=255)
