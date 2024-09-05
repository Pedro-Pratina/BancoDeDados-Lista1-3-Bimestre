USE ecommerce_22b;

-- Exercício 1: Listar todos os pedidos com detalhes do cliente.
-- Escreva uma consulta SQL que retorne o ID do pedido, a data do pedido, o nome completo do cliente e o email para todos os pedidos. Use um JOIN para combinar as tabelas Orders e Customers.

SELECT order_id, order_date, CONCAT(first_name, ' ', last_name) as name, email
FROM Orders JOIN Customers
ON Orders.customer_id = Customers.customer_id
;

-- Exercício 2: Encontrar todos os produtos pedidos por um cliente específico.
-- Escreva uma consulta SQL que retorne o nome do produto e a quantidade pedida para todos os produtos pedidos por um cliente com um customer_id específico (por exemplo, customer_id = 1). Essa consulta deve combinar as tabelas Order_Items, Orders e Products.

SELECT product_name, quantity, customer_id
FROM Products JOIN Order_Items
ON Products.product_id = Order_Items.product_id
JOIN Orders
ON Order_Items.order_id = Orders.order_id
WHERE customer_id = 1
;

-- Exercício 3: Calcular o total gasto por cada cliente.
-- Escreva uma consulta SQL que calcule o total gasto por cada cliente. O resultado deve incluir o nome completo do cliente e o total gasto. Essa consulta deve usar JOINs para combinar as tabelas Customers, Orders, Order_Items e Products, e deve usar uma função de agregação para calcular o total.

SELECT CONCAT(first_name, ' ', last_name) as name, SUM(price*quantity)
FROM Customers JOIN Orders
ON Customers.customer_id = Orders.customer_id
JOIN Order_Items
ON Orders.order_id = Order_Items.order_id
JOIN Products
ON Order_Items.product_id = Products.product_id
GROUP BY name
;

-- Exercício 4: Encontrar os clientes que nunca fizeram um pedido.
-- Escreva uma consulta SQL que retorne os nomes dos clientes que nunca fizeram um pedido. Para isso, use um LEFT JOIN entre as tabelas Customers e Orders e filtre os resultados para encontrar clientes sem pedidos.

SELECT CONCAT(first_name, ' ', last_name) as name
FROM Customers LEFT JOIN Orders
ON Customers.customer_id = Orders.customer_id
WHERE order_id IS null
;

-- Exercício 5: Listar os produtos mais vendidos.
-- Escreva uma consulta SQL que retorne o nome do produto e a quantidade total vendida, ordenando os resultados pelos produtos mais vendidos. Combine as tabelas Order_Items e Products, e utilize uma função de agregação para somar a quantidade vendida de cada produto.

SELECT product_name, SUM(quantity) as total
FROM Order_Items JOIN Products
ON Order_Items.product_id = Products.product_id
GROUP BY product_name
ORDER BY total DESC
