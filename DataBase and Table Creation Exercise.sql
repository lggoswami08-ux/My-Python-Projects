drop database if exists Shopping_Management;
Create database Shopping_management;
use Shopping_management;
Create table customers (
Customer_id INT AUTO_INCREMENT PRIMARY KEY,
Customer_name VARCHAR(100) NOT NULL,
Email VARCHAR(255) UNIQUE,
Phone_number VARCHAR(10) NOT NULL UNIQUE,
Age INT CHECK (Age > 0),
Gender VARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
Country VARCHAR(50) DEFAULT 'India',
City VARCHAR(50) NOT NULL,
Pincode CHAR(6) DEFAULT '201301',
Registration_Date DATE DEFAULT (CURRENT_DATE),
Registration_time TIME DEFAULT (CURRENT_TIME),
Create_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Address VARCHAR(250),
Customer_status VARCHAR(10) DEFAULT 'Active' CHECK ( Customer_status IN ('Active', 'Inactive', 'Block')),
Customer_Notes TEXT
) ENGINE=InnoDB;

CREATE TABLE orders (
Order_Id INT AUTO_INCREMENT PRIMARY KEY,
Customer_ID INT,
Order_date DATE DEFAULT (CURRENT_DATE),
Order_Amount DECIMAL(10,2) NOT NULL,
Order_Status VARCHAR(15) DEFAULT 'Pending' CHECK (Order_Status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
Payment_Method VARCHAR(10) DEFAULT 'Pending' CHECK (Payment_Method IN ('Pending', 'Failed')),
Shipping_Address VARCHAR(250) NOT NULL,
Delivery_Pincode CHAR(6),
Quantity INT NOT NULL CHECK (Quantity > 0),
Discount_Amount DECIMAL(10,2) DEFAULT 0.00,
Delivery_Date DATE NULL,
Create_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
Tracking_Number VARCHAR(30) UNIQUE,
Delivery_Status VARCHAR(15) DEFAULT 'Not Dispatched' CHECK (Delivery_Status IN ('Not Dispatched', 'In Transit', 'Delivered', 'Returned')),
Order_Notes TEXT,

CONSTRAINT fk_orders_customers
	FOREIGN kEY (customer_Id)
	REFERENCES customers(customer_Id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
) ENGINE=InnoDB;

SELECT * FROM customers;
SELECT * FROM orders;

INSERT INTO customers (Customer_Name, Email, Phone_Number, Age, Gender, City, Address)
VALUES ('Lakshay Giri', 'lggoswami08@gmail.com', '7310775841', 21, 'Male', 'Bulandshahr', 'Jatpure');




