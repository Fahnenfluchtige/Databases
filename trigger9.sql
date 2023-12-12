
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


