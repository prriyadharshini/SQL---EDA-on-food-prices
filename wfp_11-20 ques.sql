-- Q11. Finding out the average price of Onions and tomatoes

select * from wfp_food_prices;
select distinct(commodity), category,avg(price) over (partition by commodity) as avgprice_of_ot
from wfp_food_prices
where category="vegetables and fruits"
order by avgprice_of_ot desc ;

-- Q12 Find out which commodity has the highest price 
select commodity,max(price) as highestprice_commodity
from wfp_food_prices
group by 1
order by highestprice_commodity desc;

-- Q13 Find out the commodities which has the highest prices recently year 2002
use foodpricesdata;
select * from wfp_food_prices;
select commodity,year(date) as year,max(price)  as hihestprice
from wfp_food_prices
where year(date) = "2002"
group by 1,2
order by higestprice desc;


-- Q14 Create a table for zones

CREATE TABLE `zones` (
  `City` VARCHAR(255),
  `State` VARCHAR (255),
  `zone` VARCHAR(255),
  PRIMARY KEY(`City`, `State`)
);
Insert into zones
select DISTINCT admin2, admin1, NULL
from wfp_food_prices
where admin2 is not NULL;
SET SQL_SAFE_UPDATES = 0;

UPDATE `zones` SET zone ='South'  WHERE State LIKE 'Tamil Nadu';
UPDATE `zones` SET zone ='South'  WHERE State LIKE 'Telangana';
UPDATE `zones` SET zone ='South'  WHERE State LIKE 'Andhra Pradesh';
UPDATE `zones` SET zone ='South'  WHERE State LIKE 'Kerala';
UPDATE `zones` SET zone ='South'  WHERE State LIKE 'Karnataka';

update `zones`set zone = 'North' WHERE State = 'Himachal Pradesh';
update `zones`set zone = 'North' WHERE State = 'Punjab';
update `zones`set zone = 'North' WHERE State = 'Uttarakhand';
update `zones`set zone = 'North' WHERE State = 'Uttar Pradesh';
update `zones`set zone = 'North' WHERE State = 'Haryana';

update `zones`set zone = 'East' WHERE State = 'Bihar';
update `zones`set zone = 'East' WHERE State = 'Orissa';
update `zones`set zone = 'East' WHERE State = 'Jharkhand';
update `zones`set zone = 'East' WHERE State = 'West Bengal';

update `zones`set zone = 'West' WHERE State = 'Rajasthan';
update `zones`set zone = 'West' WHERE State = 'Gujarat';
update `zones`set zone = 'West' WHERE State = 'Goa';
update `zones`set zone = 'West' WHERE State = 'Maharashtra';

update `zones`set zone = 'Central' WHERE State = 'Madhya Pradesh';
update `zones`set zone = 'Central' WHERE State = 'Chhattisgarh';

update `zones`set zone = 'North East' WHERE State = 'Assam';
update `zones`set zone = 'North East' WHERE State = 'Sikkim';
update `zones`set zone = 'North East' WHERE State = 'Manipur';
update `zones`set zone = 'North East' WHERE State = 'Meghalaya';
update `zones`set zone = 'North East' WHERE State = 'Nagaland';
update `zones`set zone = 'North East' WHERE State = 'Mizoram';
update `zones`set zone = 'North East' WHERE State = 'Tripura';
update `zones`set zone = 'North East' WHERE State = 'Arunachal Pradesh';
  
  update `zones`set zone = 'Union Territory' WHERE State = 'Chandigarh';
update `zones`set zone = 'Union Territory' WHERE State = 'Delhi';
update `zones`set zone = 'Union Territory' WHERE State = 'Puducherry';
update `zones`set zone = 'Union Territory' WHERE State = 'Andaman and Nicobar';

select * from zones;
select * from wfp_food_prices;

-- Q15 JOIN zones table and food_prices_ind AND Create a view
create view commodity_prices as
select wfp.date,wfp.admin1,wfp.admin2,wfp.market,wfp.latitude,wfp.longitude,wfp.category,wfp.commodity,wfp.unit,wfp.priceflag,wfp.pricetype,wfp.currency
,wfp.price,wfp.usdprice,zo.city,zo.state,zo.zone
from zones zo
 join wfp_food_prices wfp
on zo.city = wfp.admin1;
select distinct market
from commodity_prices;

-- Q16 Average price of commodities zone wise 
select commodity,zone,avg(price) as commodities_Avgprice
from commodity_prices
group by commodity,zone
order by commodities_Avgprice desc;
--
-- Q17 Find out the price differences between  2002 and 2001
use foodpricesdata;
Create Table price_differC
(State varchar(255),
zone varchar(255),
category varchar(255),
commodity varchar(255),
Average_price_2002 double);

INSERT INTO price_differC
SELECT State,zone,category,commodity,round(avg(price)) as avgp from commodity_prices
WHERE year(date) = 1994 AND pricetype = "Retail"
group by 1,2,3,4;
select * from price_differC;

Create Table price_differE
(State varchar(255),
zone varchar(255),
category varchar(255),
commodity varchar(255),
Average_price_2002 double);

INSERT INTO price_differE
SELECT State,zone,category,commodity,round(avg(price)) as avgp from commodity_prices
WHERE date ='1994-01-15' AND pricetype = "Retail"
group by 1,2,3,4;

select * from price_differE;

SELECT E.state,E.zone,E.category,E.commodity,E.avgp,C.avgp,diff(e,avgp,c.avgp)
FROM price_differC
JOIN price_differE
on C.category = E.category AND C.commodity = E.commodity
order by zone;



-- Q18 Find out the average prices of each category food products zone wise

select category,zone,avg(price) as avgpr
from commodity_prices
group by 1,2
order by avgpr;

-- Q19 Find out the average prices of each commodity zone wise
SELECT distinct(commodity),zone, round(avg(price)) as avgprice
from commodity_prices
group by 1,2
order by avgprice DESC;


-- Q20 Drop unnecessary tables
drop
