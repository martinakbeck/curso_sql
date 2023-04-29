/* Qual o número de clientes únicos do estado de São Paulo? */
SELECT 
	COUNT ( DISTINCT c.customer_id ) 
FROM customer c  
WHERE c.customer_state = 'SP'

/* Qual o número total de pedidos únicos feitos no dia 08 de Outubro de 2016. */
SELECT
	COUNT ( DISTINCT o.order_id )
FROM orders o  
WHERE DATE (o.order_approved_at) = '2016-10-08'

/*  Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 . */
SELECT
	COUNT ( DISTINCT o.order_id )
FROM orders o  
WHERE DATE (o.order_approved_at) > '2016-10-08'

/* Qual o número total de pedidos únicos feitos a partir do dia 08 de Outubro de 2016 incluso.  */
SELECT
	COUNT ( DISTINCT o.order_id )
FROM orders o  
WHERE DATE (o.order_approved_at) >= '2016-10-08'

/* Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos abaixo de R$ 1.100 */
SELECT 
	COUNT ( DISTINCT oi.order_id ) AS pedidos_unicos,
	MIN ( oi.shipping_limit_date ) AS data_min_envio,
	MAX ( oi.shipping_limit_date ) AS data_max_envio,
	MIN ( oi.freight_value ) AS preco_min_frete,
	MAX ( oi.freight_value ) AS preco_max_frete,
	AVG ( oi.freight_value ) AS preco_medio_frete
FROM order_items oi 
WHERE oi.price < 1100

/* Qual o número total de pedidos únicos, a data mínima e máxima de envio, o valor máximo, mínimo e médio do frete dos pedidos abaixo de R$ 1.100 incluso? */
SELECT 
	COUNT ( DISTINCT oi.order_id ) AS pedidos_unicos,
	MIN ( oi.shipping_limit_date ) AS data_min_envio,
	MAX ( oi.shipping_limit_date ) AS data_max_envio,
	MIN ( oi.freight_value ) AS preco_min_frete,
	MAX ( oi.freight_value ) AS preco_max_frete,
	AVG ( oi.freight_value ) AS preco_medio_frete
FROM order_items oi 
WHERE oi.price <= 1100



