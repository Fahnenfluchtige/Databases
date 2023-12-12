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
  JOIN PriceList PL ON P.idProducts = PL.idProducts
  ORDER BY idProducts DESC
  LIMIT 1;
END;
$$ LANGUAGE plpgsql;

-- Создание скалярной функции для расчета средней цены за лекарства
CREATE OR REPLACE FUNCTION get_avg_drug_price()
RETURNS DECIMAL(10,2) AS $$
DECLARE
  avg_price DECIMAL(10,2);
BEGIN
  SELECT AVG(PL.Price) INTO avg_price
  FROM Drugs D
  JOIN PriceList PL ON D.idProduct = PL.idProducts;
  RETURN avg_price;
END;
$$ LANGUAGE plpgsql;

-- корзина
CREATE VIEW showBasket AS 
SELECT 
    bas.idBasket,
    p.ProductName,
    pl.price
FROM BASKET bas
JOIN PriceList pl ON bas.idProduct=pl.idProducts
JOIN Products p ON bas.idProduct=p.idProducts;


Создадим также функцию для удаления товара из корзины

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