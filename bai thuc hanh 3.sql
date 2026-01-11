create database SalesDB;
create schema sales;
create table sales.customers(
customer_id serial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not null,
phone varchar(20)
);
create table sales.products(
product_id serial primary key,
product_name varchar(100) not null,
price numeric(15,2) not null,
stock_quantity integer not null
);

create table sales.orders(
order_id serial primary key,
customer_id integer not null,
order_date date not null,
constraint fk_order_customer foreign key(customer_id) references  sales.customers(customer_id)
);
create table sales.orderitems(
order_item_id serial primary key,
order_id int not null,
product_id int not null,
quantity int not null check(quantity>=1),
constraint fk_orderitems_order foreign key (order_id) references sales.orders(order_id),
constraint fk_orderitems_product foreign key (product_id) references sales.products(product_id)
);

 