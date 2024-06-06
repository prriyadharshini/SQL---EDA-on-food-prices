use foodpricesdata;
select * from wfp_food_prices;
 --###-Q1. Count of records
 select count(*) as Number_of_records from wfp_food_prices;
 ### Answer :- Total Number of records = 45399
 
 --####-- Q2. Find out from how many states data are taken
  select count(distinct admin2) as No_states_data
 from wfp_food_prices
 where admin2 is not null;
 ###Answer:- Data taken from 58 states
 
 ##//Q3. How to find out the states which have had the highest prices of Rice under cereals and tubers category - Retail purchases
 select admin1 as state,category,pricetype,commodity,max(price) as mprice from wfp_food_prices
 where admin1 is not null and commodity = "rice" and category="cereals and tubers" and pricetype="retail"
 group by state,category,pricetype,commodity order by mprice desc;
 
 ##Q4-- Q4. Find out the states and market which have had the highest prices of Rice under cereals and tubers category- Wholesale purchases
  select admin1 as state,market,category,pricetype,commodity,max(price) as mprice from wfp_food_prices
 where commodity ="rice" and category ="cereals and tubers" and pricetype="wholesale"
 group by state,market,category,commodity,pricetype
 order by mprice desc;
 
## Q5.Find out the states and market which have had the highest prices of Milk under milk and dairy category- Retail purchases only
select admin1 as states,market,pricetype,category,commodity,max(price)as mprice from wfp_food_prices
where category ="milk and dairy" and commodity="milk" and pricetype= "retail"
group by states,market,category,commodity,pricetype
order by mprice desc;

###Q6.Find out the states and market which have had the highest prices of Milk (pasteurized) under milk and dairy category- Retail purchases only
select * from wfp_food_prices;
select admin1 as states,market,pricetype,category,commodity,max(price)as mprice from wfp_food_prices
where category ="milk and dairy" and commodity="milk(pasteurized)" and pricetype= "retail"
group by states,market,category,commodity,pricetype
order by mprice desc;

##-- Q7. Find out the states and market which have had the highest prices of Ghee (vanaspati) under oil and fats- Retail purchases only
select admin1 as states,market,pricetype,category,commodity,max(price)as mprice from wfp_food_prices
where category ="oil and fats" and commodity="ghee(vanaspati)" and pricetype= "retail"
group by states,market,category,commodity,pricetype
order by mprice desc;


-- Q8. Finding out the average price of oil and fats as whole
select category,pricetype,round(avg(price),2) as average_price
 from wfp_food_prices
 where category ="oil and fats"
group by category,pricetype
order by  average_price;

delete from wfp_food_prices
where category ="#item+type";

-- Q9. Find out the average prices for each type of oil under oil and fats
select distinct(commodity),category,avg(price) over(partition by commodity) as avgprof_oils
from wfp_food_prices
where category = "oil and fats"
order by avgprof_oils desc;


-- Q10. Finding out the average prices of lentils
select * from wfp_food_prices;
select distinct(commodity),avg(price) over(partition by commodity) as avgprice_of_lentils
from wfp_food_prices
where category ="pulses and nuts"
order by avgprice_of_lentils desc;