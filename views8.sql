


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


-- здоровье
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
LEFT JOIN Toys t ON p.idProducts Products List;



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

