CREATE DATABASE BankDB;
use BankDB;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    city VARCHAR(50) DEFAULT 'Mohali'
);

CREATE TABLE Account (
    account_number BIGINT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_type VARCHAR(20) DEFAULT 'Savings' CHECK (account_type IN ('Savings', 'Current', 'Salary', 'Fixed Deposit')),
    balance DECIMAL(12, 2) NOT NULL DEFAULT 1000.00 CHECK (balance >= 500.00),
    status VARCHAR(15) DEFAULT 'Active' CHECK (status IN ('Active', 'Inactive', 'Suspended')),
    opened_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) 
     REFERENCES Customer(customer_id)
      ON UPDATE CASCADE 
        ON DELETE RESTRICT
);

INSERT INTO Customer (customer_id, first_name, last_name, email, phone, city) VALUES
(101, 'Aman', 'Khurana', 'aman.khurana@example.com', '9876543210', 'Chandigarh'),
(102, 'Rohan', 'Sharma', 'rohan.sharma@example.com', '9876543211', 'Mohali'),
(103, 'Sneha', 'Patel', 'sneha.patel@example.com', '9876543212', 'Delhi'),
(104, 'Vikram', 'Rathore', 'vikram.rathore@example.com', '9876543213', 'Jaipur'),
(105, 'Ananya', 'Iyer', 'ananya.iyer@example.com', '9876543214', 'Bengaluru');

INSERT INTO Account (account_number, customer_id, account_type, balance, status, opened_date) VALUES
(100100201, 101, 'Savings', 45000.00, 'Active', '2024-01-15'),
(100100202, 102, 'Current', 125000.50, 'Active', '2023-11-20'),
(100100203, 103, 'Savings', 8500.00, 'Active', '2024-03-05'),
(100100204, 104, 'Salary', 62000.75, 'Active', '2023-08-12'),
(100100205, 105, 'Savings', 2400.00, 'Inactive', '2024-05-18');


SELECT account_number, customer_id, account_type, balance, status 
FROM Account 
WHERE balance > 20000.00;

SELECT account_number, customer_id, account_type, balance 
FROM Account 
ORDER BY balance DESC;

SELECT SUM(balance)
FROM Account;

SELECT 
    MAX(balance), 
    MIN(balance) 
FROM Account;

UPDATE Account 
SET balance = balance + 5000.00 
WHERE account_number = 100100203;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Account 
WHERE status = 'Inactive' AND balance < 5000.00;
SET SQL_SAFE_UPDATES = 1;
SELECT * FROM Account; 
