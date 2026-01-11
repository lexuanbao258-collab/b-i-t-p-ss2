create database UniversityDB;
create schema University;

create table Students(
student_id serial primary key,
first_name varchar(50) not  null,
last_name varchar(50) not null,
birth_date date, 
email varchar(50)not null unique 
);
create table courses(
course_id serial primary key,
course_name varchar(100) not null,
credits int
);

create table Enrollments(
enrollment_id  serial primary key,
student_id INTEGER NOT NULL,
course_id INTEGER NOT NULL,
enroll_date DATE,
constraint fk_student foreign key(student_id) references Students(student_id),
constraint fk_course  foreign key(course_id) references courses(course_id)
);
select datname from pg_database;
SELECT schema_name 
FROM information_schema.schemata;
select*from Students;
select*from courses;
select*from Enrollments;

