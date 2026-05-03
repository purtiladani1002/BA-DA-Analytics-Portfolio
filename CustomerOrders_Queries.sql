-- =============================================
-- PROJECT: Customer Orders Database
-- Author: Purti Ladani
-- Date: 2026
-- =============================================

-- Q1: All customers by signup date
SELECT * FROM Customers ORDER BY signup_date;

-- Q2: Specific columns from Orders
SELECT order_id, customer_id, order_date, payment_method, shipping_cost 
FROM Orders ORDER BY order_date;

-- Q3: Orders by payment method
SELECT * FROM Orders WHERE payment_method = 'Card';

-- Q4: Calculated total per order
SELECT order_id, quantity, unit_price, discount, total_sales,
       quantity * unit_price * (1 - discount) AS calculated_total
FROM Order_Items;

-- Q5: Orders sorted by date and shipping cost
SELECT order_id, customer_id, order_date, shipping_cost 
FROM Orders
ORDER BY order_date ASC, shipping_cost DESC;

-- Q6: Count orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM Orders
GROUP BY customer_id
ORDER BY total_orders DESC;

-- Q7: Customer names with orders
SELECT c.customer_name, o.order_id, o.order_date, o.payment_method
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY o.order_date;

-- Q8: Top spending customers
SELECT c.customer_name, 
       COUNT(o.order_id) AS total_orders,
       SUM(oi.total_sales) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Q9: Order statistics
SELECT MIN(total_sales) AS cheapest_order,
       MAX(total_sales) AS expensive_order,
       AVG(total_sales) AS avg_order_value,
       SUM(total_sales) AS total_revenue,
       COUNT(order_id) AS total_orders
FROM Order_Items;

-- Q10: Monthly sales summary
SELECT strftime('%Y-%m', o.order_date) AS order_month,
       SUM(oi.total_sales) AS monthly_sales
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;

-- Q11: Products never ordered
SELECT product_name, category
FROM Products
WHERE product_id NOT IN (
    SELECT product_id FROM Order_Items
);

-- Q12: High value orders
SELECT order_id, product_id, total_sales
FROM Order_Items
WHERE total_sales > 1000
ORDER BY total_sales DESC;

-- Q13: Update product stock
UPDATE Products
SET stock_quantity = stock_quantity - 2
WHERE product_id = 'P001';

-- Q14: Create Sales Summary View
CREATE VIEW Sales_Summary AS
SELECT c.customer_name,
       o.order_id,
       o.order_date,
       o.payment_method,
       oi.total_sales
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id;

-- Q15: Query the View
SELECT * FROM Sales_Summary;
