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
    founded_date VARCHAR(50),
    FOREIGN KEY (city_id) REFERENCES city(city_id));

CREATE TABLE industry (
industry_id INT AUTO_INCREMENT PRIMARY KEY,
industry_name VARCHAR(50));
    
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



INSERT INTO startup (city_id, startup_name, industry_id , founded_date)
SELECT DISTINCT city_id, company, industry_id, date_joined
FROM su2
JOIN industry
ON su2.industry = industry.industry_name;

SELECT * FROM startup


