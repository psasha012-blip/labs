-- Удаляем таблицы, если они существуют, чтобы избежать ошибок при повторном выполнении
DROP TABLE IF EXISTS Order_Items;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

-- Создание таблицы Покупателей
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE NOT NULL,
    recommended_by INT,
    FOREIGN KEY (recommended_by) REFERENCES Customers(customer_id)
);

-- Создание таблицы Товаров
CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Создание таблицы Заказов
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Создание таблицы Состава Заказа
CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_per_unit DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Наполнение таблиц данными
INSERT INTO Customers (customer_id, full_name, email, registration_date, recommended_by) VALUES
(1, 'Иван Иванов', 'ivan.ivanov@example.com', '2023-01-15', NULL),
(2, 'Мария Петрова', 'maria.petrova@example.com', '2023-02-20', 1),
(3, 'Алексей Смирнов', 'alex.smirnov@example.com', '2023-03-10', 1),
(4, 'Елена Васильева', 'elena.v@example.com', '2023-04-01', 2),
(5, 'Андрей Николаев', 'andrey.n@example.com', '2023-05-01', NULL);

INSERT INTO Products (product_name, category, price) VALUES
('Смартфон', 'Электроника', 70000.00),
('Ноутбук', 'Электроника', 120000.00),
('Кофемашина', 'Бытовая техника', 25000.00),
('Книга "Основы SQL"', 'Книги', 1500.00),
('Фен', 'Бытовая техника', 4500.00),
('Пылесос', 'Бытовая техника', 15000.00);

INSERT INTO Orders (customer_id, order_date, status) VALUES
(1, '2024-05-10', 'Доставлен'),
(2, '2024-05-12', 'В обработке'),
(1, '2024-05-15', 'Отправлен'),
(3, '2024-05-16', 'Доставлен');

INSERT INTO Order_Items (order_id, product_id, quantity, price_per_unit) VALUES
(1, 1, 1, 70000.00),  -- Иван купил Смартфон
(1, 4, 2, 1400.00),   -- и 2 книги
(2, 2, 1, 120000.00), -- Мария купила Ноутбук
(3, 3, 1, 25000.00),  -- Иван купил Кофемашину
(4, 1, 1, 70000.00),  -- Алексей купил Смартфон
(4, 5, 1, 4500.00);   -- и Фен

SELECT c.full_name, o.order_date FROM Customers c INNER JOIN Orders o ON c.customer_id = o.customer_id; -- 1 задание

SELECT c.full_name FROM Customers c LEFT JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL; -- 2 задание

SELECT p.product_name, oi.quantity, oi.price_per_unit FROM Order_Items oi INNER JOIN Products p ON oi.product_id = p.product_id WHERE oi.order_id = 1; -- 3 задание

SELECT full_name FROM Customers WHERE customer_id IN (-- 4 задание
    SELECT o.customer_id 
    FROM Orders o
    INNER JOIN Order_Items oi ON o.order_id = oi.order_id
    INNER JOIN Products p ON oi.product_id = p.product_id
    WHERE p.product_name = 'Смартфон'
);
SELECT product_name, price FROM Products WHERE price > ( -- 5 задание
    SELECT AVG(price) FROM Products
);
SELECT o.order_id, o.order_date FROM Orders o WHERE EXISTS ( -- 6 задание 
    SELECT 1
    FROM Order_Items oi 
    INNER JOIN Products p ON oi.product_id = p.product_id 
    WHERE oi.order_id = o.order_id
    AND p.price > 100000
);
SELECT DISTINCT c.customer_id, c.full_name -- 7 задание left join
FROM Customers AS c
LEFT JOIN Orders AS o 
ON c.customer_id = o.customer_id
LEFT JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
LEFT JOIN Products AS p 
ON oi.product_id = p.product_id AND p.product_name = 'Ноутбук'
WHERE p.product_id IS NULL;

SELECT c.customer_id, c.full_name -- 7 задание not in
FROM Customers AS c
WHERE c.customer_id NOT IN (
    SELECT o.customer_id
    FROM Orders AS o
    JOIN Order_Items AS oi 
    ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    WHERE p.product_name = 'Ноутбук'
);
SELECT p.product_name -- 8 задание
FROM Products p
LEFT JOIN Order_Items oi
    ON p.product_id = oi.product_id
WHERE oi.order_item_id IS NULL;

SELECT c.full_name AS customer_name, p.product_name, oi.quantity -- 9 задание
FROM Customers AS c
FULL OUTER JOIN Orders AS o 
ON c.customer_id = o.customer_id
FULL OUTER JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
FULL OUTER JOIN Products AS p 
ON oi.product_id = p.product_id;

SELECT DISTINCT c.full_name -- 10 задание join с подзапросом
FROM Customers AS c
JOIN Orders AS o 
ON c.customer_id = o.customer_id
JOIN Order_Items AS oi 
ON o.order_id = oi.order_id
JOIN Products AS p 
ON oi.product_id = p.product_id
WHERE p.price = (SELECT MAX(price) FROM Products);

SELECT full_name --10 задание только подзапросы
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
    WHERE order_id IN (
        SELECT order_id
        FROM Order_Items
        WHERE product_id IN (
            SELECT product_id
            FROM Products
            WHERE price = (SELECT MAX(price) FROM Products)
        )
    )
);
SELECT c.full_name, p.category -- 11 задание 
FROM Customers AS c
CROSS JOIN (
    SELECT DISTINCT category 
    FROM Products
    ) AS p
ORDER BY c.full_name, p.category;

SELECT c.full_name AS new_customer, r.full_name AS recommended_by -- 12 задание
FROM Customers AS c
JOIN Customers AS r 
ON c.recommended_by = r.customer_id;

-- Практика 9
SELECT category, -- задание 1
COUNT(*)
FROM Products GROUP BY category;

SELECT SUM(quantity * price_per_unit) -- задание 2
FROM order_items;

SELECT c.full_name, -- задание 3
COUNT(o.order_id)
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
LIMIT 2;
