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

    IF p_DrugType IS NOT NULL AND p_DrugType <> '' THEN
        INSERT INTO Drugs (idProduct, DrugType) VALUES (last_product_id, p_DrugType);
    ELSIF p_VitaminType IS NOT NULL AND p_VitaminType <> '' THEN
        INSERT INTO Vitamins (idProduct, VitaminType) VALUES (last_product_id, p_VitaminType);
    ELSIF p_CosmeticType IS NOT NULL AND p_CosmeticType <> '' THEN
        INSERT INTO Cosmetics (idProduct, CosmeticType) VALUES (last_product_id, p_CosmeticType);
    ELSIF p_ClothesType IS NOT NULL AND p_ClothesType <> '' THEN
        INSERT INTO Clothes (idProduct, ClothesType) VALUES (last_product_id, p_ClothesType);
    ELSIF p_GroomThingType IS NOT NULL AND p_GroomThingType <> '' THEN
        INSERT INTO GroomThings (idProduct, GroomThingType) VALUES (last_product_id, p_GroomThingType);
    ELSIF p_BootsType IS NOT NULL AND p_BootsType <> '' THEN
        INSERT INTO Boots (idProduct, BootsType) VALUES (last_product_id, p_BootsType);
    ELSIF p_CollarsType IS NOT NULL AND p_CollarsType <> '' THEN
        INSERT INTO Collars (idProduct, CollarsType) VALUES (last_product_id, p_CollarsType);
    ELSIF p_HarnessType IS NOT NULL AND p_HarnessType <> '' THEN
        INSERT INTO Harness (idProduct, HarnessType) VALUES (last_product_id, p_HarnessType);
    ELSIF p_ToyType IS NOT NULL AND p_ToyType <> '' THEN
        INSERT INTO Toys (idProduct, ToyType) VALUES (last_product_id, p_ToyType);
    ELSIF p_BowlPattern IS NOT NULL AND p_BowlPattern <> '' THEN
        INSERT INTO Bowl (idProduct, BowlPattern) VALUES (last_product_id, p_BowlPattern);
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
