### TABLES AND DATABASE CREATION 

CREATE DATABASE startups;

USE startups;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL);

CREATE TABLE city (
    city_id INT AUTO_INCREMENT PRIMARY KEY,
    country_id INT,
    city_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id));

CREATE TABLE startup (
    startup_id INT AUTO_INCREMENT PRIMARY KEY,
    city_id INT,
    industry_id INT,
    startup_name VARCHAR(50) NOT NULL,
    valuation VARCHAR(50),
    founded_date VARCHAR(50),
    FOREIGN KEY (city_id) REFERENCES city(city_id));

CREATE TABLE industry (
industry_id INT AUTO_INCREMENT PRIMARY KEY,
industry_name VARCHAR(50));

# 2. After creating the columns we had to import the whole startup.csv to have the data available for the further steps!! (its deleted now)

INSERT INTO industry (industry_name)
SELECT DISTINCT industry
FROM startups;

INSERT INTO Country (country_name)
SELECT DISTINCT country
FROM startups; 

SELECT * FROM Country;

CREATE VIEW su AS 
SELECT *
FROM startups
JOIN country
ON startups.country = country.country_name;

SELECT * FROM su;

INSERT INTO city (city_name, country_id)
SELECT DISTINCT city, country_id
FROM su;
    
SELECT * FROM city;

CREATE VIEW su2 AS

SELECT company, `valuation_($b)`, date_joined, country, city, industry, country_id, city_id
FROM startups
JOIN city
ON startups.city = city.city_name;


INSERT INTO startup (city_id, startup_name, valuation, industry_id , founded_date)
SELECT DISTINCT city_id, company, `valuation_($b)`, industry_id, date_joined
FROM su2
JOIN industry
ON su2.industry = industry.industry_name;

SELECT * FROM city;

ALTER TABLE startup
ADD CONSTRAINT industry_id
FOREIGN KEY (industry_id)
REFERENCES industry(industry_id);

SELECT * FROM startup;

UPDATE startup
SET valuation = TRIM(LEADING '$' FROM valuation)
WHERE valuation LIKE "%$%";

ALTER TABLE startup
MODIFY valuation INT;


### QUERIES

# Question: Where and in which industry are the highest valued startups founded?

# 1. Introduce database

use startups;

select *
from startup;

#H1: Most startups are from the US

# 1. Ranking startups by country

create view ranking_startups_by_country as 
select country_name, count(startup_name)
from country
inner join city
using (country_id)
inner join startup
using (city_id)
group by country_name 
order by count(startup_name) desc;

#H2: US startups have the highest valuations

#1. Valuation by startup

create view startups_valuation as 
select startup_name, valuation
from startup
order by valuation desc;

# 2. Average valuation of startup by country

create view country_by_avg_valuation as
select country_name, avg(valuation) 
from startup
inner join city
using (city_id)
inner join country
using (country_id)
group by country_name
order by avg(valuation) desc;

# 3. Average valuation of startup by country 

create view city_by_avg_valuation as
select city_name, avg(valuation) 
from startup
inner join city
using (city_id)
group by city_name
order by avg(valuation) desc;


# H3: The highest valued startups are in AI or data industries

# 1. Count by industry

create view startups_per_industry as
select industry_name, count(startup_name) 
from startup
inner join industry
using (industry_id)
group by industry_name
order by count(startup_name) desc;

# 2. Valuation of startups per industry 

create view avg_valuation_per_industry as
select industry_name, avg(valuation)
from startup
inner join industry
using (industry_id)
group by industry_name
order by avg(valuation) desc;

# Further queries we didn't get to
# 3. Group by timeframe to see evolution
# 4. Which industries are better represented in each country ( by startup count and valuation)
