CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(100),
    Contact_no VARCHAR(15)
);


CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary INT,
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);


CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(5, 2),
    Status VARCHAR(3),
    Author VARCHAR(50),
    Publisher VARCHAR(50)
);


CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE
);


CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);


CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- --------

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, 'Downtown Library, Kochi', '1234567890'),
(2, 102, 'Central Library, Bengaluru', '9876543210'),
(3, 103, 'City Library, Delhi', '1122334455');

select*from employee;

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(1, 'Ashly', 'Manager', 70000, 1),
(2, 'Jibin', 'Librarian', 50000, 1),
(3, 'Gopika', 'Assistant Librarian', 45000, 2),
(4, 'George', 'Manager', 80000, 2),
(5, 'Justin', 'Clerk', 40000, 3);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('978-0553380226', 'Pride and Prejudice', 'Fiction', 5.99, 'Yes', 'Jane Austen', 'Penguin Books'),
('978-0143034261', 'To Kill a Mockingbird', 'Fiction', 6.99, 'No', 'Harper Lee', 'HarperCollins Publishers'),
('978-0451524935', 'The Lord of the Rings', 'Fantasy', 9.99, 'Yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt'),
('978-0061120084', 'The Hunger Games', 'Dystopian', 7.99, 'No', 'Suzanne Collins', 'Scholastic Press');


INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'Richu', 'Kochi', '2020-12-15'),
(2, 'Goshal', 'Bengaluru', '2021-06-10'),
(3, 'Mariya', 'Delhi', '2023-03-20');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, 'Pride and Prejudice', '2024-01-01', '978-0553380226'),
(2, 2, 'To Kill a Mockingbird', '2024-01-05', '978-0143034261');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, 'Pride and Prejudice', '2024-01-10', '978-0553380226'),
(2, 2, 'To Kill a Mockingbird', '2024-01-12', '978-0143034261');


-- QUERIES--
-- 1 
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'Yes';

-- 2 
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- 3
SELECT b.Book_title, c.Customer_name 
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id;


-- 4 
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

-- 5 
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;
-- 6
SELECT c.Customer_name 
FROM Customer c
LEFT JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE c.Reg_date < '2022-01-01' AND i.Issue_Id IS NULL;

-- 7 
SELECT Branch_no, COUNT(Emp_Id) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;

-- 8 

SELECT DISTINCT c.Customer_name 
FROM IssueStatus i
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE MONTH(Issue_date) = 6 AND YEAR(Issue_date) = 2023;

-- 9 
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%History%';

-- 10 
SELECT Branch_no, COUNT(Emp_Id) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(Emp_Id) > 5;

-- 11
SELECT e.Emp_name, b.Branch_address 
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;



-- 12
SELECT DISTINCT c.Customer_name 
FROM IssueStatus i
JOIN Books b ON i.Isbn_book = b.ISBN
JOIN Customer c ON i.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;


SELECT * FROM Branch WHERE Manager_Id NOT IN (SELECT Emp_Id FROM Employee);

SELECT * FROM Books WHERE Rental_Price > 25;

SELECT b.Branch_no, b.Manager_Id, e.Emp_name 
FROM Branch b 
LEFT JOIN Employee e ON b.Manager_Id = e.Emp_Id;

UPDATE Branch
SET Manager_Id = (SELECT Emp_Id FROM Employee WHERE Emp_name = 'Harper Lee')
WHERE Branch_no = 101; -- Adjust Branch_no as needed

SELECT e.Emp_name, b.Branch_address, b.Manager_Id
FROM Employee e
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

SHOW COLUMNS FROM Branch;
SHOW COLUMNS FROM Employee;

ALTER TABLE Branch MODIFY Branch_no INT;



--   11
SELECT e.Emp_name, b.Branch_address
FROM Employee e
JOIN Branch b ON e.Branch_no = b.Branch_no
WHERE e.Position = 'Manager';

-- 12
SELECT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
JOIN Books b ON i.Isbn_book = b.ISBN
WHERE b.Rental_Price > 25;
SELECT * FROM Books WHERE Rental_Price > 25;








