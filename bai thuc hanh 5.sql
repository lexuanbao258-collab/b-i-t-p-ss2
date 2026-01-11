create database hoteldb;
create schema hotel;
create table hotel.roomtypes(
room_type_id SERIAL PRIMARY KEY,
type_name VARCHAR(50) NOT NULL UNIQUE,
price_per_night NUMERIC(10,2) CHECK (price_per_night > 0),
max_capacity INT CHECK (max_capacity > 0)
);
create table hotel.rooms(
room_id SERIAL PRIMARY KEY,
room_number VARCHAR(10) NOT NULL UNIQUE,
room_type_id INT not null,
status VARCHAR(20) CHECK (status IN ('Available','Occupied','Maintenance')),
constraint fk_room_roomtypes foreign key (room_type_id) references hotel.roomtypes(room_type_id)
);
create table hotel.customers(
customer_id SERIAL PRIMARY KEY,
full_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone  VARCHAR(15) NOT NULL
);
create table hotel.bookings(
booking_id SERIAL PRIMARY KEY,
customer_id INT not null,
room_id int not null,
check_in DATE NOT NULL,
check_out DATE NOT NULL,
status VARCHAR(20) CHECK (status IN ('Pending','Confirmed','Cancelled')),
constraint fk_booking_customer foreign key (customer_id)  references hotel.customers(customer_id),
constraint fk_booking_room foreign key (room_id) references hotel.rooms(room_id)
);
create table hotel.payments (
payment_id SERIAL PRIMARY KEY,
booking_id INT not null,
amount NUMERIC(10,2) CHECK (amount >= 0),
payment_date DATE NOT NULL,
method VARCHAR(20) CHECK (method IN ('Credit Card','Cash','Bank Transfer')),
constraint fk_payment_booking foreign key (booking_id ) references hotel.bookings(booking_id )
);