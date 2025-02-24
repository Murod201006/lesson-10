CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');


INSERT INTO orders (order_id, customer_id, order_date, total_amount) VALUES
(1, 1, '2024-10-01', 200.00),
(2, 1, '2024-10-05', 150.00),
(3, 2, '2024-10-07', 300.00),
(4, 2, '2024-10-08', 100.00),
(5, 3, '2024-10-09', 500.00);


select * from Customers
select * from orders

SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


SELECT 
    c.customer_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) > (SELECT AVG(total_spent) 
                              FROM (SELECT customer_id, SUM(total_amount) AS total_spent
                                    FROM orders
                                    GROUP BY customer_id) AS customer_totals);
