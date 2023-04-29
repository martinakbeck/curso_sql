/* Quantos clientes únicos tiveram seu pedidos com status de “processing”, “shipped” e “delivered”, 
feitos entre os dias 01 e 31 de Outubro de 2016. Mostrar o resultado somente se o número total de clientes for acima de 5.*/

SELECT 
	o.order_status AS status,
	COUNT ( DISTINCT o.customer_id)
FROM orders o 
WHERE o.order_status IN ('processing', 'shipped', 'delivered')
	AND o.order_purchase_timestamp  BETWEEN '2016-10-01' AND '2016-10-31'
GROUP BY o.order_status 
HAVING COUNT (DISTINCT o.customer_id) > 5

/*  Mostre a quantidade total dos pedidos e o valor total do pagamento, para pagamentos entre 1 e 5 prestações ou um valor de pagamento acima de R$ 5000. */
SELECT 
	op.payment_type,
	op.payment_installments,
	COUNT ( op.order_id ) AS total_pedido,
	SUM ( op.payment_value ) AS valor_total
FROM order_payments op 
WHERE op.payment_sequential BETWEEN 1 AND 5
	AND op.payment_value > 5000
GROUP BY op.payment_type, op.payment_sequential

/* Quantos produtos estão cadastrados nas categorias: perfumaria, brinquedos, esporte lazer e cama mesa, que possuem entre 5 e 10 fotos, um peso que não está entre 1 e 5 g, 
um altura maior que 10 cm, uma largura maior que 20 cm. Mostra somente as linhas com mais de 10 produtos únicos. */
SELECT 
	p.product_category_name,
	COUNT (DISTINCT p.product_id )
FROM products p 
WHERE p.product_category_name IN ('perfumaria', 'brinquedos', 'esporte_lazer', 'cama_mesa_banho') 
	AND p.product_photos_qty BETWEEN 5 AND 10
	AND p.product_weight_g  NOT BETWEEN 1 AND 5
	AND p.product_height_cm > 10
	AND p.product_width_cm > 20
GROUP BY p.product_category_name 
HAVING COUNT (DISTINCT p.product_id ) > 10


/* Refazer a consulta SQL abaixo, usando os operadores de intervalo.
SELECT   
	order_status ,  
	COUNT( order_id ) AS pedidos 
FROM orders o 
WHERE ( order_status = 'processing' OR order_status = 'canceled' )    
	AND ( o.order_estimated_delivery_date > '2017-01-01' OR o.order_estimated_delivery_date < '2016-11-23' ) 
GROUP BY order_status*/
SELECT   
	order_status ,  
	COUNT( order_id ) AS pedidos 
FROM orders o 
WHERE order_status IN ('processing', 'canceled' )    
	AND o.order_estimated_delivery_date NOT BETWEEN '2016-11-23' AND '2017-01-01'
GROUP BY order_status 


/* Qual a quantidade de cidades únicas dos vendedores no estado de São Paulo ou Rio de Janeiro com a latitude maior que -24.54 e longitude menor que -45.63? */
SELECT 
	g.geolocation_state,
	COUNT ( DISTINCT g.geolocation_city)
FROM geolocation g 
WHERE g.geolocation_state IN ('SP', 'RJ')
	AND g.geolocation_lat > -24.54
	AND g.geolocation_lng < -45.63
GROUP BY g.geolocation_state 


/* Quantos produtos estão cadastrados em qualquer categorias que comece com a letra “a” e termine com a letra “o” e que possuem mais de 5 fotos? Mostrar as linhas com mais de 10 produtos. */
SELECT 
	p.product_category_name,
	COUNT (DISTINCT p.product_id)
FROM products p 
WHERE p.product_category_name LIKE 'a%o'
	AND p.product_photos_qty > 5
GROUP BY p.product_category_name 
HAVING COUNT ( DISTINCT product_id) > 10

/* Qual o número de clientes únicos, agrupados por estado e por cidades que comecem com a letra “m”, tem a letra “o” e terminem com a letra “a”? 
Mostrar os resultados somente para o número de clientes únicos maior que 10. */
SELECT 
	c.customer_state,
	c.customer_city,
	COUNT( DISTINCT c.customer_id) 
FROM customer c 
WHERE c.customer_state LIKE 'm%o%a'
	OR c.customer_city LIKE 'm%o%a'
GROUP BY c.customer_state, c.customer_city 
HAVING COUNT( DISTINCT c.customer_id) > 10
