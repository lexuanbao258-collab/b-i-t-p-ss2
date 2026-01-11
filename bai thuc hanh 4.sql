create database elearningdb
create schema elearning

  create table elearning.students(
student_id serial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not null
);
   create table elearning.instructors(
instructor_id serial primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique not null
);
  create table elearning.courses(
course_id serial primary key,
course_name varchar(100) not null,
instructor_id int not null,
constraint fk_course_instructor foreign key (instructor_id) references elearning.instructors(instructor_id)
);

  create table elearning.enrollments(
enrollment_id serial primary key,
student_id int not null,
course_id int not null,
enroll_date date not null,
constraint fk_enrollment_student foreign key (student_id) references elearning.students(student_id),
constraint fk_enrollment_course foreign key (course_id) references  elearning.courses(course_id)
);
   create table elearning.assigments(
assignment_id serial primary key,
course_id int not null,
title varchar(100) not null,
due_date date not null,
constraint fk_assigments_course foreign key (course_id) references elearning.courses(course_id)
);
   create table elearning.submissions(
submission_id serial primary key,
assignment_id int not null,
student_id int not null,
submission_date date not null,
grade real check(grade >=0 and grade <=100),
constraint fk_submissions_assignment foreign key (assignment_id ) references elearning.assigments(assignment_id ),
constraint fk_submissions_student foreign key (student_id) references elearning.students(student_id)
);
 