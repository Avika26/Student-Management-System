-- database created 
create database student_management;
use student_management;

-- creating tables 
create table students(
Student_id INT AUTO_INCREMENT PRIMARY KEY,
Name VARCHAR(100),
Age INT,
Gender VARCHAR(10),
Department VARCHAR(50)
);

create table courses (
Course_id INT AUTO_INCREMENT PRIMARY KEY,
Course_name VARCHAR(100),
Credits int
);

create table enrollments (
Enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
Student_id INT,
Course_id INT,
Semester VARCHAR(20),
FOREIGN KEY (Student_id) REFERENCES students(Student_id),
FOREIGN KEY (Course_id) REFERENCES courses(Course_id)
);

create table marks (
Mark_id INT AUTO_INCREMENT PRIMARY KEY,
Student_id INT,
Course_id INT,
Marks INT,
FOREIGN KEY (Student_id) REFERENCES students(Student_id),
FOREIGN KEY (Course_id) REFERENCES courses(Course_id)
);

show TABLES;
-- sample data --
insert into students(Name, Age, Gender, Department) values
("Aarav Sharma", 20, "Male", "Computer Science"),
("Neha Verma", 21, "Female", "Information Technology"),
("Rohan Gupta", 19, "Male", "Electronics"),
("Priya Singh", 22, "Female", "Computer Science");

insert into courses(Course_name, Credits) values
("Database Management Systems", 4),
("Operating Systems", 3),
("Data Structures", 4);

insert into enrollments (Student_id, Course_id, Semester) values
(1, 1, "Sem 4"),
(1, 3, "Sem 4"),
(2, 1, "Sem 4"),
(3, 2, "Sem 3"),
(4, 3, "Sem 5");

insert into marks(Student_id, Course_id, Marks) values 
(1, 1, 85),
(1, 3, 90),
(2, 1, 78),
(3, 2, 88),
(4, 3, 92);

-- basic queries 
select * from students;

select Name, Department
from students
where Department = "Computer Science";

select * from courses 
where Credits > 3;

-- Joins**
-- which student in which course+sem
select s.Name, c.Course_name, e.Semester
from students s
join enrollments e on s.Student_id = e.Student_id
join courses c on e.Course_id = c.Course_id;

-- students and their marks
select s.Name, c.Course_name, m.Marks
from students s 
join marks m on s.Student_id = m.Student_id
join courses c on m.Course_id = c.Course_id;

-- average marks per course
select c.Course_name, AVG(m.Marks) as Average_marks
from courses c 
join marks m on c.Course_id = m.Course_id
group by c.Course_name;

-- students scoring more than 85
select distinct s.Name, m.Marks, c.Course_name
from students s 
join marks m on s.Student_id = m.Student_id
join courses c on c.Course_id =m.Course_id
where m.Marks>85;

-- subquery 
-- students scoring above average
select s.Name, c.Course_name, m.Marks
from students s
join marks m on s.Student_id = m.Student_id
join courses c on m.Course_id = c.Course_id
where m.Marks > (
select AVG(Marks) from marks
);

-- view
create view Student_marks_view as
select s.Name as Student_name, c.Course_name, m.Marks
from students s
join marks m on s.Student_id = m.Student_id
join courses c on m.Course_id = c.Course_id;

select * from Student_marks_view;
 
-- index
-- create index on marks table
create index idx_marks on marks(Marks);

-- Procedures 
-- procedure to get students above a certain marks
DELIMITER //
create procedure GetTopStudents(IN min_marks INT)
begin
select s.Name, c.Course_name, m.Marks
from students s
join marks m on s.Student_id = m.Student_id
join courses c on m.Course_id = c.Course_id
where m.Marks >= min_marks;
end //
DELIMITER ;

call GetTopStudents(85);

-- drop view if required
drop view if exists Student_marks_view;

-- drop procedure if required
drop procedure if exists GetTopStudents;




