SELECT category, COUNT(product_id) AS products_in_category
FROM Products GROUP BY category;

SELECT SUM(quantity * price_per_unit) AS total_revenue-- задание 2
FROM Order_Items;

SELECT c.full_name, COUNT(o.order_id)
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.full_name;

SELECT AVG(subtotal) -- задание 4
FROM (
    SELECT order_id, SUM(quantity * price_per_unit) AS subtotal
    FROM Order_Items 
    GROUP BY order_id) AS order_total;

SELECT status, COUNT(*) -- задание 5 
FROM Orders GROUP BY status;

SELECT category, COUNT(*) -- задание 6
FROM Products GROUP BY category
HAVING COUNT(*) > 1;

SELECT c.full_name -- задание 7
FROM Customers AS c
JOIN Orders AS o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
HAVING COUNT(o.order_id) > 1;

SELECT p.product_name, SUM(oi.quantity) AS total_sold -- задание 8
FROM Products AS p
JOIN Order_Items AS oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sold DESC
LIMIT 1;