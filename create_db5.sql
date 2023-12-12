
CREATE TABLE BreedOfDog (
    idBreed SERIAL PRIMARY KEY,
    breedName VARCHAR(255),
    size VARCHAR(50)
);

CREATE TABLE Products (
    idProducts SERIAL PRIMARY KEY,
    ProductName VARCHAR(255),
    ForSize VARCHAR(50),
    Color VARCHAR(50),
    Material VARCHAR(50)
);

CREATE TABLE Drugs (
    idDrugs SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    DrugType VARCHAR(50) CHECK (DrugType IN ('лекарства для ушек', 'капли для глаз', 'таблетки от блох', 'таблетки от гельминтов', 'таблетки от паразитов')));

CREATE TABLE Vitamins (
    idVitamins SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    VitaminType VARCHAR(50) CHECK (VitaminType IN ('содержащие кальций', 'для обогащения рациона', 'для поддержания здоровья шерсти')));

CREATE TABLE Cosmetics (
    idCosmetics SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    CosmeticType VARCHAR(50) CHECK (CosmeticType IN ('шампунь', 'бальзамы', 'маски для шерсти', 'масла для лапок')));

CREATE TABLE GroomThings (
    idGroomThings SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    GroomThingType VARCHAR(255) CHECK (GroomThingType IN ('когтерез', 'пуходерка', 'фурминатор'))
);


CREATE TABLE Clothes (
    idClothes SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    ClothesType VARCHAR(50) CHECK (ClothesType IN ('праздничная', 'выставочная', 'лето', 'зима', 'осень-весна'))
);

CREATE TABLE Boots (
    idBoots SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
BootsType VARCHAR(50) CHECK (BootsType IN ('праздничные', 'выставочные', 'зима', 'осень-весна', 'домашние')));

CREATE TABLE Collars (
    idCollars SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
CollarsType VARCHAR(50) CHECK (CollarsType IN ('красный кожанный ошейник с шипами', 'черный кожаный ошейник')));

CREATE TABLE Harness (
    idHarness SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
     HarnessType VARCHAR(50) CHECK (HarnessType IN ('красные', 'синие'))
);

CREATE TABLE Toys (
    idToys SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    ToyType VARCHAR(50)
);

CREATE TABLE Bowl (
    idBowl SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    BowlPattern VARCHAR(50) CHECK (BowlPattern IN ('без рисунка', 'рисунок косточка', 'рисунок лапка', 'красная', 'синяя', 'фиолетовая'))
);

CREATE TABLE PriceList (
    idPriceList SERIAL PRIMARY KEY,
    idProducts INTEGER REFERENCES Products(idProducts),
    Price FLOAT,
    Status VARCHAR(50)
);




INSERT INTO Products (ProductName, ForSize, Color, Material)
VALUES 
  ('Острые ушки', 'Средний', 'Синий', 'Жидкость'),
  ('Ca+', 'Маленький', 'Белый', 'Порошок')
  ;

INSERT INTO Drugs (idProduct, DrugType)
VALUES 
  (3, 'таблетки от гельминтов');


INSERT INTO Products (ProductName, ForSize, Color, Material)
VALUES 
  ('Здравица', 'Средний', 'Синий', 'Таблетка, покрытая оболочкой'),
  ('Tasti', 'Маленький', 'Белый', 'Порошок'),
    ('Пушистик', 'Большой', 'Белый', 'Порошок')
  ;

INSERT INTO Products (ProductName, ForSize, Color, Material)
VALUES 
  ('Сияющая Шерсть', 'Средний', 'Розовый', 'Жидкость'),
  ('Экзотические Фрукты', 'Большой', 'Желтый', 'Жидкость'),
  ('Ароматный релакс', 'Маленький', 'Фиолетовый', 'Жидкость');

INSERT INTO Cosmetics (idProduct, CosmeticType)
VALUES 
  (7, 'шампунь'),
  (8, 'бальзамы'),
  (9, 'масла для лапок');