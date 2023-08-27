use chiku;
/*with first_visit as (
select customer_id,min(order_date) as first_visit_date 
from customer_orders
group by customer_id)
,visit_flag as(
select co.*,fv.first_visit_date,
case when co.order_date=fv.first_visit_date then 1 else 0 end as first_visit_flag,
case when co.order_date!=fv.first_visit_date then 1 else 0 end as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id=fv.customer_id)
select order_date, sum(first_visit_flag) as New_Cust , sum(repeat_visit_flag) as Repeat_Cust
from visit_flag
group by order_date;

OR 
*/
with first_visit as (
select customer_id,min(order_date) as first_visit_date 
from customer_orders
group by customer_id)

select co.order_date,
sum(case when fv.first_visit_date = co.order_date then co.order_amount else 0 end) as RevByNewCust
, sum(case when fv.first_visit_date != co.order_date then co.order_amount else 0 end) as RevByRepCust,
sum(case when co.order_date=fv.first_visit_date then 1 else 0 end )as first_visit_flag,
sum(case when co.order_date!=fv.first_visit_date then 1 else 0 end )as repeat_visit_flag
from customer_orders co
inner join first_visit fv on co.customer_id=fv.customer_id
group by co.order_date;


select * from customer_orders;


