-- таблица с породами

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
    GroomThingType VARCHAR(255) CHECK (GroomThingType IN ('щетка', 'ножницы', 'перчатки', 'накладные ногти', 'полотенце'))
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

-- Пример добавления записей в таблицу PriceList
INSERT INTO PriceList (idProducts, Price, Status)
VALUES 
  (1, 10.99, 'В наличии'),
  (2, 15.99, 'В наличии'),
  (3, 8.49, 'Нет в наличии'),
  (4, 19.99, 'В наличии'),
  (5, 12.79, 'В наличии'),
  (6, 5.99, 'Нет в наличии'),
  (7, 22.49, 'В наличии'),
  (8, 18.29, 'В наличии'),
  (9, 9.99, 'В наличии');




-- Заполним таблицу PriceList с примерными ценами и статусами


CREATE TABLE Users (
    idUser SERIAL PRIMARY KEY,
    UserName VARCHAR(255),
    Password VARCHAR(255),
    Hash VARCHAR(255),
    idPriceList INTEGER REFERENCES PriceList(idPriceList)
);

CREATE TABLE Managers (
    idManager SERIAL PRIMARY KEY,
    UserName VARCHAR(255),
    Password VARCHAR(255),
    Hash VARCHAR(255)
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


SELECT
  P.idProducts AS "id товара",
  P.ProductName AS "Название товара",
  PL.Price AS "Стоимость",
  PL.Status AS "Статус"
FROM Products P
JOIN Drugs D ON P.idProducts = D.idProduct
JOIN PriceList PL ON P.idProducts = PL.idProducts;




--  информация о лекарствах
CREATE OR REPLACE FUNCTION get_drug_info()
RETURNS TABLE (
  p_id_products INTEGER,
  p_product_name VARCHAR(255),
  p_product_type VARCHAR(50),
  p_price FLOAT,
  p_status VARCHAR(50)
) AS $$
BEGIN
  RETURN QUERY 
  SELECT
    P.idProducts,
    P.ProductName,
    D.DrugType,
    PL.Price,
    PL.Status
  FROM Products P
  JOIN Drugs D ON P.idProducts = D.idProduct
  JOIN PriceList PL ON P.idProducts = PL.idProducts;
END;
$$ LANGUAGE plpgsql;

-- Создание скалярной функции для расчета средней цены за лекарства
CREATE OR REPLACE FUNCTION get_avg_drug_price()
RETURNS FLOAT AS $$
DECLARE
  avg_price FLOAT;
BEGIN
  SELECT AVG(PL.Price) INTO avg_price
  FROM Drugs D
  JOIN PriceList PL ON D.idProduct = PL.idProducts;
  RETURN avg_price;
END;
$$ LANGUAGE plpgsql;

-- Создание представления
CREATE OR REPLACE VIEW PurpleBalmsView AS
SELECT
    P.idProducts,
    P.ProductName,
    P.ForSize,
    P.Color,
    P.Material,
    C.CosmeticType
FROM
    Products P
JOIN
    Cosmetics C ON P.idProducts = C.idProduct
WHERE
    P.Color = 'фиолетовый' AND C.CosmeticType = 'бальзам';


--добавление данных

CREATE PROCEDURE InsertProduct (
    p_ProductName VARCHAR(255),
    p_ForSize VARCHAR(50),
    p_Color VARCHAR(50),
    p_Material VARCHAR(50),
    p_price FLOAT,
    p_Status VARCHAR(50),
    p_DrugType VARCHAR(50) DEFAULT NULL,
    p_VitaminType VARCHAR(50) DEFAULT NULL,
    p_CosmeticType VARCHAR(50) DEFAULT NULL,
    p_ClothesType VARCHAR(50) DEFAULT NULL,
    p_GroomThingType VARCHAR(50) DEFAULT NULL,
    p_BootsType VARCHAR(50) DEFAULT NULL,
    p_CollarsType VARCHAR(50) DEFAULT NULL,
    p_HarnessType VARCHAR(50) DEFAULT NULL,
    p_ToyType VARCHAR(50) DEFAULT NULL,
    p_BowlPattern VARCHAR(50) DEFAULT NULL
)
AS $$
DECLARE
    last_product_id INTEGER;
BEGIN
    INSERT INTO Products (ProductName, ForSize, Color, Material)
    VALUES (p_ProductName, p_ForSize, p_Color, p_Material)
    RETURNING idProducts INTO last_product_id;

    INSERT INTO PriceList(idProducts, Price, Status) 
    VALUES (last_product_id, p_price, p_Status);

    IF p_DrugType IS NOT NULL THEN
        INSERT INTO Drugs (idProduct, DrugType) VALUES (last_product_id, p_DrugType);
    ELSIF p_VitaminType IS NOT NULL THEN
        INSERT INTO Vitamins (idProduct, VitaminType) VALUES (last_product_id, p_VitaminType);
    ELSIF p_CosmeticType IS NOT NULL THEN
        INSERT INTO Cosmetics (idProduct, CosmeticType) VALUES (last_product_id, p_CosmeticType);
    ELSIF p_ClothesType IS NOT NULL THEN
        INSERT INTO Clothes (idProduct, ClothesType) VALUES (last_product_id, p_ClothesType);
    ELSIF p_GroomThingType IS NOT NULL THEN
        INSERT INTO GroomThings (idProduct, GroomThingType) VALUES (last_product_id, p_GroomThingType);
    ELSIF p_BootsType IS NOT NULL THEN
        INSERT INTO Boots (idProduct, BootsType) VALUES (last_product_id, p_BootsType);
    ELSIF p_CollarsType IS NOT NULL THEN
        INSERT INTO Collars (idProduct, CollarsType) VALUES (last_product_id, p_CollarsType);
    ELSIF p_HarnessType IS NOT NULL THEN
        INSERT INTO Harness (idProduct, HarnessType) VALUES (last_product_id, p_HarnessType);
    ELSIF p_ToysType IS NOT NULL THEN
        INSERT INTO Toys (idProduct, ToysType) VALUES (last_product_id, p_ToysType);
    ELSIF p_BowlType IS NOT NULL THEN
        INSERT INTO Bowl (idProduct, BowlType) VALUES (last_product_id, p_BowlType);
    END IF;
END;
$$ LANGUAGE plpgsql;

CALL InsertProduct (
    'Product1',
    'Size1',
    'Color1',
    'Material1',
    10.99,
    'В наличии',
    'капли для глаз');


CREATE or REPLACE PROCEDURE  DeleteProduct(
    p_idProducts INTEGER
)
AS $$

BEGIN

    DELETE FROM products WHERE idproducts=p_idProducts;

END;
$$ LANGUAGE plpgsql;


CREATE or REPLACE PROCEDURE UpdateProduct(
    p_idProducts INTEGER,
    p_newName VARCHAR(255)
)
AS $$

BEGIN
    UPDATE products
    SET ProductName = p_newName
    WHERE idProducts = p_idProducts;
END;
$$ LANGUAGE plpgsql;





-- Вывод товаров в наличии
CREATE OR REPLACE VIEW isHere AS 
SELECT 
    p.idProducts,
    p.ProductName,
    pl.Price,
    pl.Status,
    CASE
    WHEN d.idDrugs IS NOT NULL THEN d.DrugType
        WHEN c.idCosmetics IS NOT NULL THEN c.CosmeticType
        WHEN v.idVitamins IS NOT NULL THEN 'витаминка ' || v.VitaminType
        WHEN g.idGroomThings IS NOT NULL THEN g.GroomThingType
        WHEN cl.idClothes IS NOT NULL THEN 'одежда для времени года ' || cl.ClothesType
        WHEN b.idBoots IS NOT NULL THEN 'обувь для времени года ' || b.BootsType
        WHEN col.idCollars IS NOT NULL THEN 'ошейник'
        WHEN h.idHarness IS NOT NULL THEN 'шлейка'
        WHEN t.idToys IS NOT NULL THEN 'игрушка'
        WHEN bow.idBowl IS NOT NULL THEN 'миска'
    END AS ProductType
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
LEFT JOIN Drugs d ON p.idProducts = d.idProduct
LEFT JOIN Cosmetics c ON p.idProducts = c.idProduct
LEFT JOIN Vitamins v ON p.idProducts = v.idProduct
LEFT JOIN GroomThings g ON p.idProducts = g.idProduct
LEFT JOIN Clothes cl ON p.idProducts = cl.idProduct
LEFT JOIN Boots b ON p.idProducts = b.idProduct
LEFT JOIN Collars col ON p.idProducts = col.idProduct
LEFT JOIN Harness h ON p.idProducts = h.idProduct
LEFT JOIN Toys t ON p.idProducts = t.idProduct
LEFT JOIN Bowl bow ON p.idProducts = bow.idProduct
WHERE pl.Status = 'В наличии';

-- вывести одежду и обувь
CREATE OR REPLACE VIEW Fashion AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    cl.ClothesType AS FashionType,
    pl.price,
    pl.Status
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Clothes cl ON p.idProducts = cl.idProduct

UNION

SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    b.BootsType AS FashionType,
    pl.price,
    pl.Status
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Boots b ON p.idProducts = b.idProduct;

CREATE OR REPLACE VIEW Health AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    d.DrugType AS HType,
    pl.price,
    pl.Status
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Drugs d ON p.idProducts = d.idProduct

UNION

SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    v.VitaminType AS HType,
    pl.price,
    pl.Status
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Vitamins v ON p.idProducts = v.idProduct;


CREATE TABLE BASKET (
    idBasket SERIAL PRIMARY KEY,
    idProduct INTEGER REFERENCES Products(idProducts),
    idUser INTEGER REFERENCES auth_user(id)
);
-- вывести породы собак для пользователя
CREATE VIEW showBasket AS 
SELECT 
    bas.idBasket,
    p.ProductName,
    pl.price
FROM BASKET bas
JOIN PriceList pl ON bas.idProduct=pl.idProducts
JOIN Products p ON bas.idProduct=p.idProducts;

CREATE OR REPLACE VIEW Fashion AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    cl.ClothesType AS FashionType,
    pl.price,
    pl.Status
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Clothes cl ON p.idProducts = cl.idProduct


dogshop=# CREATE VIEW ProductsWithCosmetics AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    c.CosmeticType,
    pl.price
FROM
    Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
RIGHT JOIN Cosmetics c ON p.idProducts = c.idProduct
WHERE
    pl.Status = 'В наличии';


CREATE VIEW ProductsWithGroomThings AS
SELECT
p.idProducts,
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    g.GroomThingType
FROM
    Products p
LEFT JOIN
    GroomThings g ON p.idProducts = g.idProduct;

CREATE VIEW ProductsWithClothes AS
SELECT
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    cl.ClothesType
FROM
    Products p
LEFT JOIN
    Clothes cl ON p.idProducts = cl.idProduct;

CREATE VIEW ProductsWithBoots AS
SELECT
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    b.BootsType
FROM
    Products p
LEFT JOIN
    Boots b ON p.idProducts = b.idProduct;

CREATE VIEW ProductsWithCollars AS
SELECT
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    co.CollarsType
FROM
    Products p
LEFT JOIN
    Collars co ON p.idProducts = co.idProduct;

CREATE VIEW ProductsWithHarness AS
SELECT
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    h.HarnessType
FROM
    Products p
LEFT JOIN
    Harness h ON p.idProducts = h.idProduct;





CREATE VIEW ProductsWithToys AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    t.ToyType
FROM
    Products p
LEFT JOIN
    Toys t ON p.idProducts = t.idProduct;

CREATE VIEW ProductsWithBowl AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    bo.BowlPattern
FROM
    Products p
LEFT JOIN
    Bowl bo ON p.idProducts = bo.idProduct;


-- Добавление товаров  в корзину
CREATE or REPLACE PROCEDURE  AddProductBasket(
    p_idProducts INTEGER
)
AS $$
BEGIN

    INSERT INTO Basket(idProduct) VALUES(p_idProducts);
END;
$$ LANGUAGE plpgsql;


--вывести список пользователей

CREATE VIEW showUsers AS 
SELECT 
    u.idUser,
    u.UserName
FROM Users u;

-- вывод всех товаров
CREATE OR REPLACE VIEW isHereforManager AS 
SELECT 
    p.idProducts,
    p.ProductName,
    pl.Price,
    pl.Status,
    CASE
     WHEN d.idDrugs IS NOT NULL THEN d.DrugType
        WHEN c.idCosmetics IS NOT NULL THEN c.CosmeticType
        WHEN v.idVitamins IS NOT NULL THEN 'витаминка ' || v.VitaminType
        WHEN g.idGroomThings IS NOT NULL THEN g.GroomThingType
        WHEN cl.idClothes IS NOT NULL THEN 'одежда для времени года ' || cl.ClothesType
        WHEN b.idBoots IS NOT NULL THEN 'обувь для времени года ' || b.BootsType
        WHEN col.idCollars IS NOT NULL THEN 'ошейник'
        WHEN h.idHarness IS NOT NULL THEN 'шлейка'
        WHEN t.idToys IS NOT NULL THEN 'игрушка'
        WHEN bow.idBowl IS NOT NULL THEN 'миска'
        ELSE 'неизвестно' 
    END AS ProductType
FROM Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
LEFT JOIN Drugs d ON p.idProducts = d.idProduct
LEFT JOIN Cosmetics c ON p.idProducts = c.idProduct
LEFT JOIN Vitamins v ON p.idProducts = v.idProduct
LEFT JOIN GroomThings g ON p.idProducts = g.idProduct
LEFT JOIN Clothes cl ON p.idProducts = cl.idProduct
LEFT JOIN Boots b ON p.idProducts = b.idProduct
LEFT JOIN Collars col ON p.idProducts = col.idProduct
LEFT JOIN Harness h ON p.idProducts = h.idProduct
LEFT JOIN Toys t ON p.idProducts Products List


CREATE OR REPLACE VIEW isHereforUser AS 
SELECT *
FROM isHereforManager
WHERE Status = 'В наличии';

CREATE VIEW ProductsWithVitamins AS
SELECT
    p.ProductName,
    p.ForSize,
    p.Color,
    p.Material,
    v.VitaminType
FROM
    Products p
JOIN
    Vitamins v ON p.idProducts = v.idProduct;




ALTER TABLE PriceList
DROP CONSTRAINT IF EXISTS PriceList_idproduct_fkey,  -- Удаляем существующий внешний ключ, если он есть
ADD CONSTRAINT PriceList_idproduct_fkey FOREIGN KEY (idProduct) REFERENCES Products(idProducts) ON DELETE CASCADE;




CREATE FUNCTION ChangeStatus ()
RETURNS TRIGGER AS $$
DECLARE
    last_product_id INTEGER;
BEGIN

    SELECT idProduct 
    INTO last_product_id
    FROM Basket 
    ORDER BY idBasket 
    DESC LIMIT 1;

    UPDATE PriceList
    SET Status = 'Нет в наличии'
    WHERE idProducts = last_product_id;

    RETURN NEW;


END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_product_to_basket_trigger
AFTER INSERT ON basket
FOR EACH ROW EXECUTE FUNCTION ChangeStatus();


CREATE FUNCTION DeleteFromBasket( p_idbasket INTEGER)
RETURNS INTEGER 
AS $$
    DECLARE
    last_product_id INTEGER;
BEGIN

    SELECT idProduct 
    INTO last_product_id
    FROM Basket 
    WHERE idBasket = p_idbasket;


    DELETE FROM basket WHERE idbasket=p_idbasket;

    UPDATE PriceList
    SET Status = 'В наличии'
    WHERE idProducts = last_product_id;
    RETURN 0;
END;
$$ LANGUAGE plpgsql;





CREATE OR REPLACE VIEW Rig AS
SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    'Collar' AS HType,
    pl.price,
    pl.Status
FROM
    Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Collars c ON p.idProducts = c.idProduct
WHERE
    pl.Status = 'В наличии'

UNION

SELECT
    p.idProducts,
    p.ProductName,
    p.ForSize,
    'Harness' AS HType,
    h.HarnessType AS SubType,
    pl.price,
    pl.Status
FROM
    Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Harness h ON p.idProducts = h.idProduct
WHERE
    pl.Status = 'В наличии';


CREATE OR REPLACE VIEW Accesuars AS
SELECT
    p.idProducts,
    p.ProductName,
    'Toy' AS HType,
    t.ToyType AS SubType,
    pl.price
FROM
    Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Toys t ON p.idProducts = t.idProduct
WHERE
    pl.Status = 'В наличии'

UNION

SELECT
    p.idProducts,
    p.ProductName,
    'Bowl' AS HType,
    b.BowlPattern AS SubType,
    pl.price
FROM
    Products p
JOIN PriceList pl ON p.idProducts = pl.idProducts
JOIN Bowl b ON p.idProducts = b.idProduct
WHERE
    pl.Status = 'В наличии';


ALTER TABLE GroomThings DROP CONSTRAINT groomthings_groomthingtype_check