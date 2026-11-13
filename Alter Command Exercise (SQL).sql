Drop database if exists ddl_Commands;
create DATABASE DDL_Commands;
use DDL_Commands;

CREATE TABLE my_table(
id INT,
name VARCHAR(100) Not NULL,
age int NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO my_table (id, name, age) VALUES
(1,'Rohit', 25),
(2,'Sachin', 35),
(3,'Vikas',28);

-- Create my_table2
-- Create my_table2
CREATE TABLE my_table2(
id INT,
description VARCHAR(255) NOT NULL
);

-- insert data into my_table2
INSERT INTO my_table2(id, description) VALUES
(1,'Item 1'),
(2,'Item 2'),
(3,'Item 3');
 
 select * from my_table;
 select * from my_table2;
 
 -- #1
 Alter Table my_table
 Change Column name full_name varchar(100) not null;
 
 -- #2
 Alter Table my_table
 Modify age Bigint not null;
 
-- #3
Alter Table my_table
ADD COLUMN email varchar(100) not null;

-- #4
Alter Table my_table
Add column middle_name varchar(50) after full_name;

-- #5
Alter Table my_table
Add column EMP_Rank int first;

-- #6
Alter Table my_table
Modify created_at datetime;

-- #7
Alter Table my_table2
Modify description text;

-- #8
Alter Table my_table
Modify Column full_name varchar(255) null;

-- #9
Alter Table my_table
add primary key(id);

-- #10
Alter Table my_table
drop column middle_name;

-- #11
Alter Table my_table
Rename column email to email_add;

-- #12
Alter Table my_table
Modify age int null;

-- #13
Alter Table my_table2
add constraint fk_id
Foreign key (id)
References my_table(id);

-- #14
Alter Table my_table2
drop foreign key fk_id;

-- #15
Alter Table my_table
modify full_name varchar(200) not null;

-- #16
drop table my_table2;

-- #18
Alter Table my_table
drop primary key;

-- #19
Alter Table my_table
drop column age;

-- #20
drop database DDL_Commands




