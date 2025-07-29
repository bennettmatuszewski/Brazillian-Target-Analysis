CREATE OR REPLACE VIEW overview_kpis AS
SELECT
  orders.order_id AS order_id,
  customers.customer_id AS customer,
  customers.customer_state AS customer_state,
  payments.payment_value AS revenue,
  payments.payment_type as payment_type,
  orders.order_purchase_timestamp AS order_date,
  EXTRACT(DAY FROM orders.order_delivered_customer_date - orders.order_purchase_timestamp) AS delivery_days,
  (order_delivered_customer_date > order_estimated_delivery_date) AS order_delivered_late
FROM orders
JOIN payments ON orders.order_id = payments.order_id
JOIN customers ON orders.customer_id = customers.customer_id
WHERE orders.order_delivered_customer_date IS NOT NULL;
