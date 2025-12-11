-- Customer Performance Analysis
create database cpa;
use cpa;

Select * FROM `cpa`.`customer purchasing behaviors`;

-- 1. How many customers does this store have?

SELECT count(*) as total_counts
 FROM `cpa`.`customer purchasing behaviors`;

-- Insights
-- a. worth noting, this dataset has no duplicates.
-- b. A total number of 238 clients purchased from the store.

-- 2. What is the average income for the client who come to this store?

select 
	round(avg(annual_income), 2) AS avg_annual_income,
	round(avg(annual_income)/12, 2) as avg_monthly_income,
    min(annual_income) AS min_annual_income,
    max(annual_income) AS max_annual_income,
    min((annual_income)/12) AS min_monthly_income,
    max((annual_income)/12) AS max_monthly_income
FROM `cpa`.`customer purchasing behaviors`;
  
  -- insights 
  -- a. The average monthly income is 4783.96.
  -- b. The average annual income is 57407.56.
  -- c. The minimum annual income is 30000.
  -- d. The maximum annual income is 75000.
  -- e. The minimum monthly income is 2500.
  -- f. The maximum monthly income is 6250. 
  
  -- 3. What is the client average anuual income by age?
  -- Use case statement
  -- Use groupby
  
  SELECT 
	case
		when age <= 30 then '30 and younger'
        when age <= 40 then '31-40 years'
		else 'older than 40'
	end as age_group,
	round(avg(annual_income), 2) AS avg_annual_income,
    count(user_id) as client_count,
  avg(age) AS avg_age,
  min(age) AS min_age,
  max(age) AS max_age
	FROM `cpa`.`customer purchasing behaviors`
GROUP BY 1;
    
-- Insights
-- a. The avg_age = 38.6765, min_age = 22, and max_age = 55.
-- b. The age group with higher purchasing power using annual income is older than 40.
-- c. Clients who are older than age 40 are majority in numbers to visit the store. 

-- 4. What is the average purchase amount by age?
SELECT 
	case
		when age <= 30 then '30 and younger'
        when age <= 40 then '31-40 years'
		else 'older than 40'
	end as age_group,
	round(avg(purchase_amount), 2) AS avg_purchase_amount,
    count(user_id) as client_count
FROM `cpa`.`customer purchasing behaviors`
WHERE purchase_amount IS NOT NULL
	GROUP BY 1;
    
-- Insights
-- a. The average purchase amount is more for age group older than 40 and are highest 
-- in numbers.

-- 5. What is the average income and the purchase amount by loyalty score?
Select 
	case
		when loyalty_score <= 3 then 'Minimum'
        when loyalty_score <= 6 then 'Medium'
		else 'maximum_loyalty'
    End AS loyal_group, 
    case
		when age <= 30 then '30 and younger'
        when age <= 40 then '31-40 years'
		else 'older than 40'
	end as age_group,
    round(avg(purchase_amount), 2) AS avg_purchase_amount,
    round(avg(annual_income), 2) AS avg_annual_income,
 avg(loyalty_score) as avg_loyalty_score,
 min(loyalty_score) as min_loyalty_score,
 max(loyalty_score) as max_loyalty_score
FROM `cpa`.`customer purchasing behaviors`
group by 1, 2;

-- insights
-- a. The customers having maximum loyalty has average purchse amount of 516.


-- 6. What is the average income and purchase amount by purchase frequency?
Select * FROM `cpa`.`customer purchasing behaviors`;

SELECT 
	case
		when purchase_frequency <= 10 then '<10'
        when purchase_frequency <= 20 then '<20'
        else '>21'
	END AS purchase_freq,
    case
		when age <= 30 then '30 and younger'
        when age <= 40 then '31-40 years'
		else 'older than 40'
	end as age_group,
    round(avg(purchase_amount), 2) AS avg_purchase_amount,
    round(avg(annual_income), 2) AS avg_annual_income,
    count(user_id) as client_count,
	AVG(purchase_frequency) as avg_purchase_frequency,
    min(purchase_frequency) as min_purchase_frequency,
    max(purchase_frequency) as max_purchase_frequency
 FROM `cpa`.`customer purchasing behaviors`
group by 1, 2;

SELECT 
    client_count,
    avg_purchase_amount,
    (avg_purchase_amount * client_count) AS estimated_total_spend
FROM (
    SELECT 
        COUNT(user_id) AS client_count,
        AVG(purchase_amount) AS avg_purchase_amount
    FROM `cpa`.`customer purchasing behaviors`
) AS subquery;

-- Insights
-- a. The min purchase frequency is 10, avg is 20, and the max is 28.
-- b. The higher the purchase frequency the higher the annual income and purchase amount.
-- c. The group that has highest number of clients is older than 40 with highest purchase frequency.
