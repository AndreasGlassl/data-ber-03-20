Select price
FROM olist.order_items
ORDER BY price asc	
LIMIT 1;

Select price
FROM olist.order_items
ORDER BY price desc	
LIMIT 1;

Select min(price) as min_price, max(price) as max_price
from olist.order_items;

select order_item_id, min(shipping_limit_date) as date_from, max(shipping_limit_date) as date_to
from olist.order_items
group by order_item_id
limit 1;

select customer_state, count(*) as count
from olist.customers
group by customer_state
order by count desc
limit 3;

select customer_city, count(*) as count
from olist.customers
where customer_state = 'SP'
group by customer_city
order by count desc
limit 3;

select count(distinct(business_segment)) as number_of_business_segments
from olist.closed_deals;

select business_segment, sum(declared_monthly_revenue) as total_revenue
from olist.closed_deals
where declared_monthly_revenue > '0'
group by business_segment
order by total_revenue desc
limit 3;


select count(distinct review_score) as number_of_values
from olist.order_reviews;


select review_score, count(review_score) as number_of_scores
from olist.order_reviews
group by review_score
order by review_score desc
limit 1;
