/*  Qual o número de clientes únicos de todos os estados? */
SELECT
	customer_state,
	COUNT( customer_unique_id) AS numero_clientes
FROM customer c 
GROUP BY customer_state 

/* Qual o número de cidades únicas de todos os estados? */
SELECT   
	customer_state,
	customer_city,
	COUNT( DISTINCT customer_city ) AS numero_cidades 
FROM customer c  
GROUP BY customer_state

/* Qual o número de clientes únicos por estado e por cidade? */
SELECT
	c.customer_state,
	c.customer_city,
	COUNT( c.customer_id ) AS clientes
FROM customer c  
GROUP BY c.customer_state, c.customer_city


/* Qual o número total de pedidos únicos acima de R$ 3.500 por cada vendedor? */
SELECT
	COUNT ( DISTINCT oi.order_id),
	oi.seller_id
FROM order_items oi 
WHERE oi.price > 3500
GROUP BY oi.seller_id 

/* Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos acima de R$ 1.100 por cada vendedor? */
SELECT 
	COUNT ( DISTINCT oi.order_id ) AS pedidos_unicos,
	MIN ( oi.shipping_limit_date ) AS data_min_envio,
	MAX ( oi.shipping_limit_date ) AS data_max_envio,
	MIN ( oi.freight_value ) AS preco_min_frete,
	MAX ( oi.freight_value ) AS preco_max_frete,
	AVG ( oi.freight_value ) AS preco_medio_frete
FROM order_items oi 
WHERE oi.price > 1100
GROUP BY oi.seller_id 

/* Qual o valor médio, máximo e mínimo do preço de todos os pedidos de cada produto? */
SELECT
	oi.product_id AS produto_unico,
	MIN( oi.price ) AS preco_mon_pedido,
	MAX ( oi.price ) AS preco_max_pedido,
	AVG ( oi.price ) AS preco_medio_pedido
FROM order_items oi 
GROUP BY oi.product_id 

/* Qual a quantidade de vendedores distintos que receberam algum pedido antes do dia 23 de setembro de 2016 e qual foi o preço médio desses pedidos? */
SELECT 
oi.shipping_limit_date,
	COUNT ( oi.seller_id ) AS qtd_vendedores,
	AVG (oi.price) AS preco_medio_pedidos
FROM orders o, order_items oi 
WHERE o.order_purchase_timestamp < '2016-09-23'


/* Qual a quantidade de pedidos por tipo de pagamentos? */
SELECT 
	op.payment_type AS tipo_pagamento, 
	COUNT (op.order_id) AS qtd_pedidos
FROM order_payments op  
GROUP BY op.payment_type 

/* Qual a quantidade de pedidos, a média do valor do pagamento e o número máximo de parcelas por tipo de pagamentos? */
SELECT 
	COUNT ( op.order_id) AS pedidos, 
	op.payment_type AS tipo_pagamento,
	AVG ( op.payment_value) AS media_preco,
	MAX (op.payment_sequential) AS max_parcelas
FROM order_payments op 
GROUP BY op.payment_type 

/* Qual a valor mínimo, máximo, médio e as soma total paga por cada tipo de pagamento e número de parcelas disponíveis? */
SELECT 
	op.payment_type AS tipo_pagamento,
	op.payment_installments AS n_parcelas,
	MIN ( op.payment_value) AS valor_min_pedido,
	MAX ( op.payment_value) AS valor_max_pedido,
	SUM ( op. payment_value) AS valor_total_pedido
FROM order_payments op 
GROUP BY op.payment_type, op.payment_installments 

/* Qual a média de pedidos por cliente? */
SELECT 
	DISTINCT o.customer_id AS clientes,
	AVG (o.order_id) AS media_pedido
FROM orders o 
GROUP BY customer_id 

/* Qual a quantidade de pedidos realizados por cada status do pedido, a partir do dia 23 de Setembro de 2016? */
SELECT 
	o.order_status AS status_pedido,
	COUNT ( o.order_id ) AS total_pedido
FROM orders o 
WHERE o.order_approved_at > '2016-09-23'
GROUP BY o.order_status 

/* Qual a quantidade de pedidos realizados por dia, a partir do dia 23 de Setembro de 2016? */
SELECT 
	o.order_approved_at AS data_pedido,
	COUNT ( o.order_id ) AS total_pedido
FROM orders o 
WHERE o.order_approved_at  > '2016-09-23'
GROUP BY DATE ( o.order_approved_at )  

/* Quantos produtos estão cadastrados na empresa por categoria? */
SELECT 
	product_category_name,
	COUNT( DISTINCT product_id)
FROM products p 
GROUP BY product_category_name 

