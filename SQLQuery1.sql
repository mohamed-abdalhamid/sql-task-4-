use StoreDB

go

SELECT COUNT(*) AS total_products FROM production.products;


go


SELECT 
  AVG(list_price) AS avg_price,
  MIN(list_price) AS min_price,
  MAX(list_price) AS max_price
FROM production.products;

go


SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM production.categories c
LEFT JOIN production.products p ON c.category_id = p.category_id
GROUP BY c.category_name;


go


SELECT s.store_name, COUNT(o.order_id) AS order_count
FROM sales.stores s
LEFT JOIN sales.orders o ON s.store_id = o.store_id
GROUP BY s.store_name;


go


SELECT 
  UPPER(first_name) AS first_name_upper,
  LOWER(last_name) AS last_name_lower
FROM sales.customers
ORDER BY customer_id
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


go


SELECT 
  product_name, 
  LEN(product_name) AS name_length
FROM production.products
ORDER BY product_id
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


go


SELECT 
  customer_id,
  LEFT(phone, 3) AS area_code
FROM sales.customers
ORDER BY customer_id
OFFSET 0 ROWS FETCH NEXT 15 ROWS ONLY;


go


SELECT 
  GETDATE() AS current_date,
  order_id,
  YEAR(order_date) AS order_year,
  MONTH(order_date) AS order_month
FROM sales.orders
ORDER BY order_id
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


go


SELECT 
  p.product_name,
  c.category_name
FROM production.products p
JOIN production.categories c ON p.category_id = c.category_id
ORDER BY p.product_id
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


go


SELECT 
  c.first_name + ' ' + c.last_name AS customer_name,
  o.order_date
FROM sales.customers c
JOIN sales.orders o ON c.customer_id = o.customer_id
ORDER BY o.order_id
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


go


SELECT 
  p.product_name,
  ISNULL(b.brand_name, 'No Brand') AS brand_name
FROM production.products p
LEFT JOIN production.brands b ON p.brand_id = b.brand_id;


go


SELECT 
  product_name,
  list_price
FROM production.products
WHERE list_price > (SELECT AVG(list_price) FROM production.products);


go


SELECT 
  customer_id,
  first_name + ' ' + last_name AS customer_name
FROM sales.customers
WHERE customer_id IN (SELECT DISTINCT customer_id FROM sales.orders);


go


SELECT 
  c.first_name + ' ' + c.last_name AS customer_name,
  (SELECT COUNT(*) FROM sales.orders o WHERE o.customer_id = c.customer_id) AS total_orders
FROM sales.customers c;


go


CREATE VIEW easy_product_list AS
SELECT 
  p.product_name,
  c.category_name,
  p.list_price
FROM production.products p
JOIN production.categories c ON p.category_id = c.category_id;

SELECT * FROM easy_product_list WHERE list_price > 100;


go


CREATE VIEW customer_info AS
SELECT 
  customer_id,
  first_name + ' ' + last_name AS full_name,
  email,
  city + ', ' + state AS location
FROM sales.customers;

SELECT * FROM customer_info WHERE location LIKE '%, CA';


go


SELECT 
  product_name,
  list_price
FROM production.products
WHERE list_price BETWEEN 50 AND 200
ORDER BY list_price ASC;


go

SELECT 
  state,
  COUNT(*) AS customer_count
FROM sales.customers
GROUP BY state
ORDER BY customer_count DESC;


go


SELECT 
  c.category_name,
  p.product_name,
  p.list_price
FROM production.products p
JOIN production.categories c ON p.category_id = c.category_id
WHERE p.list_price = (
  SELECT MAX(list_price)
  FROM production.products p2
  WHERE p2.category_id = p.category_id
);


go


SELECT 
  s.store_name,
  s.city,
  COUNT(o.order_id) AS order_count
FROM sales.stores s
LEFT JOIN sales.orders o ON s.store_id = o.store_id
GROUP BY s.store_name, s.city;
