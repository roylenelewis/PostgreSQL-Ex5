-- Create a trigger to update stock quantity when an order item is inserted

CREATE OR REPLACE FUNCTION update_stock_quantity()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;

    -- Ensure stock quantity does not go below zero
    IF (SELECT stock_quantity FROM products WHERE product_id = NEW.product_id) < 0 THEN
        RAISE EXCEPTION 'Insufficient stock for product %', NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_stock_trigger
AFTER INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION update_stock_quantity();



-- Create a trigger to prevent orders with insufficient stock

CREATE OR REPLACE FUNCTION check_stock_availability()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT stock_quantity FROM products WHERE product_id = NEW.product_id) < NEW.quantity THEN
        RAISE EXCEPTION 'Insufficient stock for product %', NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_stock_trigger
BEFORE INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION check_stock_availability();

-- Create triggers to log changes to orders


CREATE OR REPLACE FUNCTION log_order_changes()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO order_log (order_id, change_type)
    VALUES (OLD.order_id, 'UPDATE');

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_order_update_trigger
AFTER UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION log_order_changes();

CREATE OR REPLACE FUNCTION log_order_deletion()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO order_log (order_id, change_type)
    VALUES (OLD.order_id, 'DELETE');

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_order_delete_trigger
BEFORE DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION log_order_deletion();
