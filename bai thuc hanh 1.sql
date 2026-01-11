

create database librarydb;
create schema library;
create table library.book(	
	bookid serial primary key,
	title varchar(100) not null,
	author varchar(50) not null,
	published_year integer,
	price numeric(15,2)
);
select datname from pg_database;
SELECT schema_name 
FROM information_schema.schemata;
select*from library.book;