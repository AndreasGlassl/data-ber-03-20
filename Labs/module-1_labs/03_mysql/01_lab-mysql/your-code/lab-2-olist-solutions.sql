select min(first_contact_date) as  earliest_contact, max(first_contact_date) as latest_contact
from marketing_qualified_leads
limit 1;


select 
	origin,
	count(origin) as count	
from marketing_qualified_leads
group by origin
order by count desc
limit 3;

select
	first_contact_date,
	count(mql_id) as number
from marketing_qualified_leads
group by first_contact_date
order by number desc
limit 1;

 
 
select 
	product_category_name,
	count(product_category_name) as count
from products
group by product_category_name
order by count desc
limit 2;

select
	product_category_name,
	product_weight_g
from products
order by product_weight_g desc
limit 1;

select 
	product_category_name,
	(product_length_cm+product_height_cm+product_width_cm) as product_cm
from olist.products
order by product_cm desc
limit 1;

select 
	payment_type,
	count(payment_type) as counts
from order_payments
group by payment_type
order by counts desc
limit 1;

select 
	`order_id`,
	payment_value
from order_payments
order by payment_value desc
limit 1;

select 
	seller_state,
	count(distinct seller_city) as cities
from sellers
group by seller_state
order by cities desc
limit 10;

