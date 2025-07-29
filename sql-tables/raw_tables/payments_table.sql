CREATE TABLE payments(
    payment_id TEXT PRIMARY KEY,
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value DEC(7,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);