CREATE TABLE Item (

ItemName VARCHAR (30) NOT NULL,
ItemType CHAR(1) NOT NULL,
ItemColour VARCHAR(10),

PRIMARY KEY (ItemName));

CREATE TABLE Employee (

EmployeeNumber SMALLINT UNSIGNED NOT NULL ,
EmployeeName VARCHAR(10) NOT NULL ,
EmployeeSalary INTEGER UNSIGNED NOT NULL ,
DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
BossNumber SMALLINT UNSIGNED NOT NULL REFERENCES Employee,

PRIMARY KEY (EmployeeNumber));

CREATE TABLE Department (

DepartmentName VARCHAR(10) NOT NULL,
DepartmentFloor SMALLINT UNSIGNED NOT NULL,
DepartmentPhone SMALLINT UNSIGNED NOT NULL,
EmployeeNumber SMALLINT UNSIGNED NOT NULL REFERENCES
Employee,PRIMARY KEY (DepartmentName));

CREATE TABLE Sale (

SaleNumber INTEGER UNSIGNED NOT NULL,
SaleQuantity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
ItemName VARCHAR(30) NOT NULL REFERENCES Item,
DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
PRIMARY KEY (SaleNumber));

CREATE TABLE Supplier (

SupplierNumber INTEGER UNSIGNED NOT NULL,
SupplierName VARCHAR(30) NOT NULL,
PRIMARY KEY (SupplierNumber));

CREATE TABLE Delivery (

DeliveryNumber INTEGER UNSIGNED NOT NULL,
DeliveryQuantity SMALLINT UNSIGNED NOT NULL DEFAULT 1,
ItemName VARCHAR(30) NOT NULL REFERENCES Item,
DepartmentName VARCHAR(10) NOT NULL REFERENCES Department,
SupplierNumber INTEGER UNSIGNED NOT NULL REFERENCES
Supplier,
PRIMARY KEY (DeliveryNumber));

.separator "\t"
.import delivery.txt Delivery
.import department.txt Department
.import sale.txt Sale
.import employee.txt Employee
.import item.txt Item
.import supplier.txt Supplier


-- Develop queries for the following...

-- 1.	What are the names of employees in the Marketing Department?
SELECT DISTINCT EmployeeName FROM Employee,Department WHERE Employee.DepartmentName = "Marketing" ;
-- 2.	Find the average salary of the employees in the Clothes department.
SELECT AVG(EmployeeSalary) FROM Employee,Department WHERE Employee.DepartmentName = "Clothes" ;
-- 3.	 List the items delivered by exactly one supplier (i.e. the items always delivered by the same supplier).
SELECT ItemName
FROM Delivery
GROUP BY ItemName
HAVING COUNT(DISTINCT SupplierNumber) = 1;
--Develop nested queries for the following...
-- 4.	List the departments for which each item delivered to the department is delivered to some other department as well.

SELECT DISTINCT DepartmentName AS 'Department Name' FROM Delivery WHERE ItemName IN (SELECT ItemName FROM Delivery GROUP BY DepartmentName HAVING COUNT(*) >1) ORDER BY DepartmentName;

-- 5.	Among all the departments with a total salary greater than £25000, find the departments that sell Stetsons.
SELECT DISTINCT DepartmentName,EmployeeSalary FROM Employee WHERE DepartmentName IN (SELECT DepartmentName FROM Sale WHERE ItemName ='Sextant' ) AND EmployeeSalary IN (SELECT SUM(EmployeeSalary) AS 'total' FROM Employee GROUP BY DepartmentName HAVING total > 25000) ORDER BY DepartmentName;

-- 6.	Find the suppliers that deliver compasses and at least three other kinds of item.
SELECT DISTINCT Delivery.SupplierNumber,Supplier.SupplierName FROM (Supplier NATURAL JOIN Delivery) WHERE (SELECT COUNT (ItemName) FROM Delivery WHERE ItemName <> 'Compass')  >= 3 AND SupplierNumber IN (SELECT SupplierNumber FROM Delivery WHERE ItemName = 'Compass');