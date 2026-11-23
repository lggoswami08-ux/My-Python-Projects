-- 1. Safely recreate the database for clean practice runs
DROP DATABASE IF EXISTS interview_commands_practice;
CREATE DATABASE interview_commands_practice;
USE interview_commands_practice;

SET autocommit = 1;

-- 2. Create table with proper constraints
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(60) NOT NULL,
    department VARCHAR(30) NOT NULL,
    city VARCHAR(40),
    salary DECIMAL(10, 2) CHECK (salary > 0),
    employment_status ENUM('Active', 'Inactive') DEFAULT 'Active',
    phone VARCHAR(15) UNIQUE
) ENGINE = InnoDB;

-- 3. Insert sample records
INSERT INTO employees
    (employee_id, employee_name, department, city, salary, employment_status, phone)
VALUES
    (1, 'Rahul Sharma', 'IT', 'Delhi', 45000.00, 'Active', '9000000001'),
    (2, 'Priya Verma', 'HR', 'Mumbai', 42000.00, 'Active', '9000000002'),
    (3, 'Amit Patel', 'Sales', 'Ahmedabad', 38000.00, 'Inactive', '9000000003'),
    (4, 'Anjali Singh', 'IT', 'Kolkata', 50000.00, 'Active', '9000000004'),
    (5, 'Vijay Kumar', 'Finance', 'Bangalore', 55000.00, 'Active', '9000000005'),
    (6, 'Sanjay Reddy', 'Sales', 'Hyderabad', 36000.00, 'Active', '9000000006'),
    (7, 'Megha Iyer', 'IT', 'Chennai', 48000.00, 'Active', '9000000007'),
    (8, 'Neha Gupta', 'HR', 'Delhi', 32000.00, 'Inactive', '9000000008'),
    (9, 'Arjun Mehta', 'Finance', 'Pune', 52000.00, 'Active', '9000000009'),
    (10, 'Pooja Shah', 'Sales', 'Mumbai', 40000.00, 'Active', '9000000010');
    
    select * from employees;
    
    -- QUESTION 1;
    
    INSERT INTO employees
   ( employee_id, employee_name, department, city, salary, employment_status, phone)
   values
   (11, 'karan Malhotra', 'IT', 'noida', 41000.00, 'Active', '9000000011');
   
   select * 
   from employees
   where employee_id = 11;
   
   -- Question 2.
    
INSERT INTO employees
(employee_id, employee_name, department, city, salary, employment_status, phone)
Values
(12, 'Simran Kaur', 'HR', 'Noida', 41000, 'Active', '9000000012'),
(13, 'Rohan Das', 'Sales', 'Pune', 33000, 'Inactive', '9000000013');

select *
from employees
where employee_id in(12,13);

-- QUESTION 3
 
UPDATE employees
set city = 'Gurgoan',
salary = 46000
where employee_id = 11;

select * 
from employees
where employee_id = 11;

-- QUESTION 4

UPDATE employees
SET salary = salary * 1.10
where employee_id in (1,4,7);

select employee_id, employee_name, salary
from employees
where employee_id in (1,4,7);

-- QUESTION 5

DELETE FROM employees
where employee_id in (3,8,13);

select * 
from employees
where employee_id in (3,8,13);

-- QUESTION 6

ALTER TABLE employees
ADD COLUMN email varchar(100) NULL;

SELECT * FROM EMPLOYEES;

-- QUESTION 7 

ALTER TABLE employees
MODIFY COLUMN phone varchar(20) NULL;

SELECT employee_id, employee_name, phone
from employees;

-- QUESTION 8

ALTER TABLE employees
RENAME COLUMN city to work_city;

select employee_id, employee_name, work_city
from employees;

-- QUESTION 9

ALTER TABLE employees
drop column email;

select * 
from employees;

-- QUESTION 10

RENAME TABLE employees TO staff;
show tables;

SELECT * FROM staff;

-- QUESTION 11

START transaction;

-- insert a new employee into staff
INSERT INTO staff
( employee_id, employee_name, department, work_city, salary, employment_status, phone)
values
(14, 'NISHA RAO', 'ID', 'NOIDA', 44000.00, 'ACTIVE', '9000000014');

-- update the salary of employee id 2
UPDATE STAFF
SET SALARY = 45000.00
WHERE EMPLOYEE_ID = 2;

-- SAVE BOTH CHAGNES PERMANENTLY
COMMIT;

ROLLBACK;

SELECT *
FROM staff
WHERE employee_id = 14;

select employee_id, employee_name, salary
from staff 
where employee_id = 2;

-- QUESTION 12

START TRANSACTION;

UPDATE staff
SET salary = 60000.00
where employee_id = 5;

DELETE FROM staff
WHERE employee_id = 6;

ROLLBACK;

SELECT employee_id, employee_name, salary
FROM staff
where employee_id = 5;

SELECT *
FROM staff
where employee_id = 6;

-- QUESTION 13
START TRANSACTION;

UPDATE staff
SET salary = 47000.00
where employee_id = 14;

-- QUESTION 14
START TRANSACTION;

-- REMOVE ALL ROWS FRM STAFF

TRUNCATE TABLE staff;

-- Attemp to undo the operation

ROLLBACK;

SELECT *
from staff;



SAVEPOINT city_saved;

DELETE FROM staff
where employee_id = 14;

ROLLBACK TO SAVEPOINT city_saved;

COMMIT;

SELECT employee_id, employee_name, work_city, salary
from staff
where employee_id = 14;

SAVEPOINT savepoint_name;
ROLLBACK TO SAVEPOINT savepoint_name;

COMMIT;
