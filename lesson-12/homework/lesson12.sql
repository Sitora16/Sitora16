Create table Person (personId int, firstName varchar(255), lastName varchar(255))
Create table Address (addressId int, personId int, city varchar(255), state varchar(255))
Truncate table Person
insert into Person (personId, lastName, firstName) values ('1', 'Wang', 'Allen')
insert into Person (personId, lastName, firstName) values ('2', 'Alice', 'Bob')
Truncate table Address
insert into Address (addressId, personId, city, state) values ('1', '2', 'New York City', 'New York')
insert into Address (addressId, personId, city, state) values ('2', '3', 'Leetcode', 'California')

select p.firstName,p.lastName,a.city, a.state from person as p
left join Address as a
on p.personId=a.personId


--2
Create table Employee (id int, name varchar(255), salary int, managerId int)
Truncate table Employee
insert into Employee (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employee (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employee (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employee (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)


select e.name as employee from Employee as e
join employee as m
on e.managerId=m.id
where e.salary>m.salary;


--3
Create table Person (id int, email varchar(255))
 insert into Person(id, email) values ('1', 'a@b.com')
                      insert into Person (id, email) values ('2', 'c@d.com')
					  insert into Person (id, email) values ('3', 'a@b.com')

select email from person
Group by email
having count(email)>1;

--4
create table personnn(id int,email varchar (100))
insert into personnn(id,email) values ('1', 'john@example.com'),('2', 'bob@example.com'),('3', 'john@example.com')

select email from personnn
Group by email
having count(email)>1 

delete p1 from personnn as p1
join personnn as p2
on p1.email=p2.email and p1.id>p2.id;
select * from personnn

--5
CREATE TABLE boys (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

CREATE TABLE girls (
    Id INT PRIMARY KEY,
    name VARCHAR(100),
    ParentName VARCHAR(100)
);

INSERT INTO boys (Id, name, ParentName) 
VALUES 
(1, 'John', 'Michael'),  
(2, 'David', 'James'),   
(3, 'Alex', 'Robert'),   
(4, 'Luke', 'Michael'),  
(5, 'Ethan', 'David'),    
(6, 'Mason', 'George');  


INSERT INTO girls (Id, name, ParentName) 
VALUES 
(1, 'Emma', 'Mike'),  
(2, 'Olivia', 'James'),  
(3, 'Ava', 'Robert'),    
(4, 'Sophia', 'Mike'),  
(5, 'Mia', 'John'),      
(6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');



select distinct g.parentname from girls as g
where g.ParentName not in (select b.parentname from boys as b);

--6
SELECT 
    customer_id,
    SUM(CASE WHEN weight > 50 THEN amount ELSE 0 END) AS total_sales_over_50,
    MIN(weight) AS least_weight
FROM 
    Orders
GROUP BY 
    customer_id;

--7
DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;
GO

CREATE TABLE Cart1
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

CREATE TABLE Cart2
(
Item  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO Cart1 (Item) VALUES
('Sugar'),('Bread'),('Juice'),('Soda'),('Flour');
GO

INSERT INTO Cart2 (Item) VALUES
('Sugar'),('Bread'),('Butter'),('Cheese'),('Fruit');
GO

select c1.Item, c2.Item from Cart1 as c1
full join cart2 as c2
on c1.item=c2.Item
where c1.item=c2.Item 
select * from Cart2

--8
Create table Customerss (id int, name varchar(255))
Create table Orderss (id int, customerId int)
Truncate table Customerss
insert into Customerss (id, name) values ('1', 'Joe')
insert into Customerss (id, name) values ('2', 'Henry')
insert into Customerss (id, name) values ('3', 'Sam')
insert into Customerss (id, name) values ('4', 'Max')
Truncate table Orderss
insert into Orderss (id, customerId) values ('1', '3')
insert into Orderss (id, customerId) values ('2', '1')

select c.name as customers from customerss as c
left join orderss as o
on c.id=o.customerId
where o.customerId is null

--9
Create table Studentss (student_id int, student_name varchar(20))
Create table Subjects (subject_name varchar(20))
Create table Examinations (student_id int, subject_name varchar(20))
Truncate table Studentss
insert into Studentss(student_id, student_name) values ('1', 'Alice')
insert into Studentss (student_id, student_name) values ('2', 'Bob')
insert into Studentss (student_id, student_name) values ('13', 'John')
insert into Studentss (student_id, student_name) values ('6', 'Alex')
Truncate table Subjects
insert into Subjects (subject_name) values ('Math')
insert into Subjects (subject_name) values ('Physics')
insert into Subjects (subject_name) values ('Programming')
Truncate table Examinations
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Programming')
insert into Examinations (student_id, subject_name) values ('2', 'Programming')
insert into Examinations (student_id, subject_name) values ('1', 'Physics')
insert into Examinations (student_id, subject_name) values ('1', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Math')
insert into Examinations (student_id, subject_name) values ('13', 'Programming')
insert into Examinations (student_id, subject_name) values ('13', 'Physics')
insert into Examinations (student_id, subject_name) values ('2', 'Math')
insert into Examinations (student_id, subject_name) values ('1', 'Math')

select s.student_id, s.student_name, sub.subject_name, count(exam.subject_name) as attexam from studentss as s
cross join Subjects as sub
left join Examinations as exam
on s.student_id=exam.student_id and sub.subject_name=exam.subject_name
Group by s.student_id,s.student_name,sub.subject_name
order by s.student_id,sub.subject_name
