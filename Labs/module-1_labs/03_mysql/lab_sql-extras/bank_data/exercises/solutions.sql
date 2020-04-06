select 
	client_id
from client
where district_id = 1
order by client_id asc
limit 5;

select
	client_id
from client
where district_id = 72
order by client_id desc
limit 1;

select 
	amount
from loan
order by amount asc
limit 3;

select  
	distinct status
from loan
order by status asc;

select 
	loan_id
 from loan
 order by payments desc
 limit 1;
 
select  
	account_id,
	amount
from loan
order by account_id
limit 5;

select
	account_id,
	amount
from loan
where duration = 60
order by amount
limit 5;

select 
	distinct k_symbol
from bank.order;

select order_id 
from bank.order
where account_id = 34;

select
	distinct account_id
from bank.order
where (order_id >= 29540
	and order_id <= 29560);
	
	
select
	amount
from bank.order
where account_to = 30067122;

select 
	trans_id,
	trans.date,
	trans.type,
	amount
from trans
where account_id = 793
order by trans.date desc
limit 10
;

-- -----------------------------------
-- This is the part of lab2
-- -----------------------------------

select 
	district_id,
	count(1) 	as clients
from bank.client
where district_id < 10
group by district_id
order by district_id asc;

select 
	account_id,
	sum(amount) as all_loans
from loan
group by account_id
order by all_loans desc
limit 10
;


select
	loan.date,
	count(*) 	as number_of_loans
from loan
where loan.date < 930907
group by loan.date
order by loan.date desc;

select
	loan.date,
	count(*) 	as number_of_loans,
	duration
from loan
where
	loan.date >= 971201
	and loan.date < 980101
group BY
	loan.date,
	duration
order by
	loan.date,
	duration
; 

select
	account_id,
	trans.type,
	sum(amount) as total_amount
from trans
where
	account_id = 396
group by trans.type
order by trans.type;

select 
	account_id,
	if(trans.type = 'PRIJEM', 'INCOMIN', 'OUTGOING') 		   as transaction_type,
	floor(sum(amount)) as round_down_amount
from trans
where account_id = 396
group by 
	account_id,
	trans.type
;

select
	account_id,
	Floor(sum(if(trans.type = "PRIJEM", amount, 0))) 	as INCOMING,
	Floor(sum(if(trans.type = "VYDAJ", amount, 0))) 	as OUTGOING,
	Floor(sum(if(trans.type = "PRIJEM", amount, 0)))-Floor(sum(if(trans.type = "VYDAJ", amount, 0))) as NET_DIF
from trans
group by account_id
order by NET_DIF DESC
limit 10;
