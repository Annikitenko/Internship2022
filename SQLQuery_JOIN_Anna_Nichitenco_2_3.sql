/*Inner JOIN

1.	Customers and internet packages (Customers & Packages tables) 
a)	Write a query to display first name, last name, package number and internet speed for all customers.*/
SELECT c.First_Name, c.Last_Name, p.pack_id, p.speed 
FROM customers AS c
INNER JOIN packages AS p 
ON c.pack_id=p.pack_id;


/*b)	Write a query to display first name, last name, package number and internet speed for all customers whose package number equals 22 or 27. Order the query in ascending order by last name.*/
SELECT c.First_Name, c.Last_Name, p.pack_id, p.speed 
FROM customers as c
INNER JOIN packages as p 
ON c.pack_id=p.pack_id
WHERE p.pack_id IN(22,27);


/*c)	Display the package number and the number of customers for each package number.*/
SELECT p.pack_id, count(c.customer_id) AS number_of_customers
FROM packages AS p
INNER JOIN customers AS c
ON p.pack_id=c.pack_id
GROUP BY p.pack_id;

/*d)	Modify the query to display the package number and number of customers for each package number, only for the customers whose monthly discount is greater than 20.*/

SELECT p.pack_id,  COUNT(c.customer_id) AS number_of_customers
FROM packages AS p
INNER JOIN (SELECT * from customers WHERE monthly_discount>20) as c
ON p.pack_id=c.pack_id
GROUP BY  p.pack_id;

SELECT p.pack_id,  COUNT(c.customer_id) AS number_of_customers
FROM packages AS p
INNER JOIN customers as c
ON p.pack_id=c.pack_id
WHERE c.monthly_discount>20
GROUP BY  p.pack_id;


/*e)	Modify the query to display the package number and number of customers for each package number, only for the packages with more than 100 customers.*/
SELECT p.pack_id, COUNT(c.customer_id) AS number_of_customers
FROM packages AS p
INNER JOIN customers AS c
ON p.pack_id=c.pack_id
GROUP BY p.pack_id
HAVING  COUNT(c.customer_id)>100;

/*	Display the package id and the average monthly discount for each package.*/
SELECT p.pack_id, AVG(c.monthly_discount) AS average_monthly_discount
FROM packages AS p
INNER JOIN customers AS c
ON p.pack_id=c.pack_id
GROUP BY p.pack_id;

/*	Display the package id and the average monthly discount for each package, only for packages whose id equals 22 or 13.*/
SELECT p.pack_id, AVG(c.monthly_discount) AS average_monthly_discount
FROM packages AS p
INNER JOIN customers AS c
ON p.pack_id=c.pack_id
WHERE p.pack_id=22 OR p.pack_id=13
GROUP BY p.pack_id;

/*2.	Internet packages and sectors 
a.	Display the customer name, package number, internet speed, monthly payment and sector name for all customers (Customers, Packages and Sectors tables).*/
SELECT c.First_Name+' '+c.Last_Name as Customer_name, p.pack_id, p.speed, p.monthly_payment, s.sector_name
FROM customers AS c
INNER JOIN packages AS p 
ON c.pack_id=p.pack_id
INNER JOIN sectors AS s 
ON p.sector_id=s.sector_id;

/*b.	Display the customer name, package number, internet speed, monthly payment and sector name for all customers in the business sector (Customers, Packages and Sectorstables).*/
SELECT c.First_Name+' '+c.Last_Name as Customer_name, p.pack_id, p.speed, p.monthly_payment, s.sector_name
FROM customers AS c
INNER JOIN packages AS p 
ON c.pack_id=p.pack_id
INNER JOIN sectors AS s 
ON p.sector_id=s.sector_id
WHERE s.sector_name like 'Business';

/*3.	Display the last name, first name, join date, package number, internet speed and sector name for all customers in the private sector who joined the company in the year 2006.*/
SELECT c.Last_Name, c.First_Name, c.Join_Date, p.pack_id, p.speed, s.sector_name
FROM (SELECT * from customers WHERE YEAR(Join_Date)=2006) AS c
INNER JOIN packages AS p 
ON c.pack_id=p.pack_id
INNER JOIN sectors AS s 
ON p.sector_id=s.sector_id
WHERE s.sector_name='Private';


/*Outer Join
4.	Customers and internet packages (Customers and Packages tables)
a.	Display the first name, last name, internet speed and monthly payment for all customers. Use INNER JOIN to solve this exercise.*/
SELECT c.First_Name, c.Last_Name, p.speed, p.monthly_payment
FROM customers AS c
INNER JOIN packages AS p 
ON c.pack_id=p.pack_id;

/*b.	Modify last query to display all customers, including those without any internet package.*/
SELECT c.First_Name, c.Last_Name, p.speed, p.monthly_payment
FROM customers AS c
LEFT JOIN packages AS p 
ON c.pack_id=p.pack_id;

/*c.	Modify last query to display all packages, including those without any customers.*/
SELECT p.pack_id, c.First_Name, c.Last_Name, p.speed, p.monthly_payment
FROM customers AS c
RIGHT JOIN packages AS p 
ON c.pack_id=p.pack_id;

/*	Modify last query to display all packages and all customers */
SELECT p.pack_id, c.Last_Name, c.First_Name, p.speed, p.monthly_payment
FROM customers AS c
FULL OUTER JOIN packages AS p 
ON c.pack_id=p.pack_id;

/*Queries using IN, EXISTS, ANY, ALL*/ 

SELECT Last_Name, First_Name, pack_id from customers 
WHERE pack_id in (SELECT pack_id FROM packages WHERE speed='750Kbps');

SELECT c.Last_Name, c.First_Name, c.state, c.pack_id FROM customers AS c 
WHERE EXISTS (SELECT p.pack_id FROM packages AS p 
WHERE p.pack_id=c.pack_id and p.speed='750Kbps' AND c.state='New York');

SELECT c.Last_Name, c.First_Name, c.state, c.pack_id from customers as c 
WHERE c.pack_id = ANY (SELECT p.pack_id from packages AS p 
WHERE p.pack_id=c.pack_id and p.speed='750Kbps' AND c.state='Chisinau');

SELECT pack_id, monthly_payment from packages AS p 
WHERE monthly_payment>= ALL(SELECT monthly_payment FROM packages AS p1); 
