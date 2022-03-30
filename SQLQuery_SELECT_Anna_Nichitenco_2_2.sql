/*Write projection queries for DB and use order by to get ordered result*/

SELECT Last_Name, First_Name, pack_id FROM customers
WHERE pack_id>10
ORDER BY pack_id DESC, Last_name;

SELECT pack_id, speed, strt_date, monthly_payment FROM packages
WHERE YEAR(strt_date)>2007
ORDER BY strt_date DESC;

SELECT sector_id, sector_name from sectors where sector_id<>1 
ORDER BY sector_name, sector_id;

/*Correlated subqueries*/
SELECT * from (SELECT Customer_ID, First_name, Last_name, Join_Date, State, City, monthly_discount, pack_id FROM customers 
WHERE YEAR(Join_Date)>=2008) as c
WHERE STATE = (SELECT Top 1 State FROM customers WHERE City = 'New York') OR STATE = (SELECT Top 1 State FROM customers WHERE City = 'Durham')
ORDER BY state, monthly_discount DESC;

SELECT p.sector_id, (Select s.sector_name from sectors as s where p.sector_id=s.sector_id) as sector_name, avg(p.monthly_payment) as average_montly_payment from packages as p 
GROUP BY p.sector_id
HAVING p.sector_id= (SELECT s.sector_id from sectors as s WHERE s.sector_name='Private');


/*Select first name, last name and birth date of customers which names start with “Jo”(Customers table).*/
-- First name AND Last name start with “Jo” together
SELECT First_Name, Last_Name, Birth_Date FROM customers
WHERE Last_name LIKE 'Jo%'	AND First_Name LIKE 'Jo%';

-- First name OR Last name start with “Jo” 
SELECT First_Name, Last_Name, Birth_Date FROM customers
WHERE Last_name LIKE 'Jo%'	OR First_Name LIKE 'Jo%';

/*Select first name, last name and birth date of customers in which second letter in first name is “o”(Customers table).*/
SELECT First_Name, Last_Name, Birth_Date FROM customers
WHERE First_Name LIKE '_o%';

/*Select the first three first name, last name, pack_id, secondary_phone_num   of customers which pack_id is null and state secondary_phone_num  is not null (Customers table).*/
SELECT TOP 3 First_Name, Last_Name, pack_id, secondary_phone_num FROM customers
WHERE pack_id IS NULL and secondary_phone_num IS NOT NULL;

/*Display  sector id and sector name which sector name is (value 1, or value 3, or value  4 , or  value 5) and not value  2, or value 7(sectors table).*/
SELECT sector_id, sector_name FROM sectors
WHERE (sector_name='value 1' OR sector_name='value 3' OR sector_name='value 4' OR sector_name='value 5') AND (sector_name!='value 2' OR sector_name!='value 7');

SELECT sector_id, sector_name FROM sectors
WHERE sector_name LIKE 'value [1,3,4,5]' and sector_name LIKE 'value [^2,7]';

/*Display the lowest last name alphabetically (Customers table).*/
SELECT TOP 1 Last_name AS The_lowest_Last_Name FROM customers
ORDER BY last_name;

/*Display the average monthly payment (Packages table).*/
SELECT AVG(monthly_payment) AS average_monthly_payment FROM packages;


/*Display the highest last name alphabetically (Customers table).*/
SELECT TOP 1 Last_name AS The_highest_Last_Name FROM customers
ORDER BY last_name DESC;

/*Display the number of internet packages (Packages table).*/
SELECT COUNT(pack_id) AS 'The number of internet packages' FROM packages;


/*Display the number of records in Customers table.*/
SELECT COUNT(*) AS 'The number of records in Customers' FROM customers;

/* Display the number of distinct states  (Customers table).*/
SELECT COUNT(DISTINCT state) AS 'The number of distinct states' FROM customers;

/*Display the number of distinct internet speeds (Packages table)*/
SELECT COUNT(DISTINCT speed) AS 'The number of distinct internet speeds' FROM packages;

/*Display the number of values (exclude Nulls) in Fax column (Customers table)*/
SELECT COUNT(fax) AS 'The number of values (exclude Nulls) in Fax column' FROM Customers
WHERE fax IS NOT NULL;

/*Display the number of Null values in Fax column (Customers table).*/
SELECT COUNT(*) AS 'The number of Nulls values in Fax column' FROM Customers
WHERE fax IS NULL;

/*Display the highest, lowest and average monthly discount (Customers table).*/
SELECT MAX (monthly_discount) AS highest_monthly_discount, 
MIN(monthly_discount) AS lowest_monthly_discount, AVG(monthly_discount) AS average_monthly_discount 
FROM customers;


/*Part 2 – GROUP BY and HAVING clauses

Display the state and the number of customers for each state (Customers table).*/
SELECT state, COUNT(Customer_Id) AS number_of_customers FROM customers
GROUP BY state;

/* Display the internet speed and the average monthly payment for each speed (Packages table)*/
SELECT speed, avg(monthly_payment) as avg_monthly_payment FROM packages
GROUP BY speed;

/*Display the state and the number of distinct cities for each state (Customers table).*/
SELECT state, COUNT(DISTINCT city) AS number_of_distinct_cities FROM customers
GROUP BY state;

/*Display the sector number and the highest monthly payment for each sector (Packages table)*/
SELECT sector_id, MAX(monthly_payment) AS highest_monthly_payment FROM packages
GROUP BY sector_id;

/*Number of packages and average monthly discount (Customers table)*/
SELECT pack_id, COUNT(pack_id) AS quantity_of_packages, AVG(monthly_discount) AS average_monthly_discount FROM customers
GROUP BY pack_id;

/*Display the highest, lowest and average monthly payment for each internet speed (Packages table)*/
SELECT speed, MAX(monthly_payment) AS the_highest_monthly_payment, MIN(monthly_payment) AS the_lowest_monthly_payment, avg(monthly_payment) AS the_average_monthly_payment from packages
GROUP BY speed;

/*The number of customer in each internet package (Customers table)*/
SELECT packages.speed, COUNT(customers.Customer_Id) AS number_of_customers from packages, customers
WHERE packages.pack_id = customers.pack_id
GROUP BY packages.speed;

SELECT COUNT(Customer_Id) AS number_of_customers, pack_id from customers
GROUP BY pack_id;

/*Display the package id and the number of customers for each package id*/
SELECT pack_id, COUNT(Customer_Id) AS number_of_customers from customers
GROUP BY pack_id;

/*Modify the query to display the package id and number of customers for each package id, only for the customers whose monthly discount is greater than 20.*/
SELECT pack_id, COUNT(Customer_Id) AS number_of_customers from customers
WHERE monthly_discount>20
GROUP BY pack_id;

/*Modify the query to display the package id and number of customers for each package id, only for the packages with more than 100 customers.*/
SELECT pack_id, COUNT(Customer_Id) AS number_of_customers FROM customers
GROUP BY pack_id
HAVING COUNT(Customer_Id)>100;

/*Display the state, city and number of customers for each state and city*/
SELECT state, city, COUNT(customer_id) as 'number_of_customers' from customers as c
GROUP BY state, city
ORDER BY state;
SELECT state, COUNT(customer_id) as 'number_of_customers' from customers as c
GROUP by state
ORDER by state;

/*Display the city and the average monthly discount for each city*/
SELECT city, AVG(monthly_discount) AS average_monthly_discount FROM customers
GROUP BY city;

/*Display the city and the average monthly discount for each city, only for the customers whose monthly discount is greater than 20*/
SELECT city, AVG(monthly_discount) AS average_monthly_discount FROM customers 
WHERE monthly_discount>20
GROUP BY city;

/*Display the state and the lowest monthly discount for each state. (Customers table)*/
SELECT state, MIN(monthly_discount) AS min_monthly_discount FROM customers
GROUP BY state
ORDER by state;

/*Display the state and lowest monthly discount for each state, only for states where the lowest monthly discount is greater than 10*/
SELECT state, MIN(monthly_discount) AS min_monthly_discount FROM customers
GROUP BY state
HAVING MIN(monthly_discount)>10
ORDER BY state; 

/*Display the internet speed and number of package for each internet speed, only for the internet speeds with more than 8 packages.*/
SELECT speed, count(pack_id) from packages
GROUP BY speed
HAVING count(pack_id)>8;

