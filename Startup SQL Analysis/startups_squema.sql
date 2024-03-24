create database startups;

use startups;

create table startup (
startup_id int not null unique auto_increment primary key,
startup_name varchar (40),
valuation int,
date_founded varchar (40));

create table industry (
Industry_ID int not null unique auto_increment primary key,
Industry_name varchar (40));

create table city (
city_id int not null unique auto_increment primary key,
city_name varchar (40));

create table country (
country_id int not null unique auto_increment primary key,
country_name varchar (40));



