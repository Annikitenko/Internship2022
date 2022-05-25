/* Book store database*/

Create database Book_Store;

Create table Suppliers(
Supplier_ID int Primary Key,
Supplier_Name nvarchar(100) not Null,
Supplier_Address varchar (255),
Supplier_Phone varchar(30),
);
Create table Books(
Book_ID int identity(1,1) Primary key,
Book_title nvarchar(255) not null,
Book_author nvarchar(255) not null,
Book_publication_data int,
Book_ISBN varchar(100) Unique not null,
Book_price_current Smallmoney not null,
Supplier_ID int Foreign Key References Suppliers(Supplier_ID) on delete set NULL
);
Create table Books_Prices(
Book_ID int Not Null Foreign Key References Books(Book_ID),
Date_from Datetime Primary Key default getdate(),
Book_price Money Not null
check(Book_price>0)
);
Create table Customers(
Customer_ID int Primary Key,
First_Name varchar(100) not null,
Last_Name varchar(100) not null,
Customer_Phone varchar(30) not null,
Customer_Email varchar(100) Unique not null,
Customer_Adress varchar(255) not null,
);

Create table Customer_Orders(
Order_ID int identity(1,1) Primary key,
Customer_ID int Not null Foreign Key References Customers(Customer_ID),
Order_sum Money Not null,
Order_Date Date Not null
);


Create table Customer_Order_Books(
Order_ID int Not null Foreign Key References Customer_Orders(Order_ID),
Book_ID int Not Null Foreign Key References Books(Book_ID),
Quantity int Not Null
Unique(Order_ID, Book_ID)
);

Create table Payment_Method (
Payment_Method_ID varchar(100) Primary Key,
Order_ID int Not null Unique Foreign Key References Customer_Orders(Order_ID),
Order_sum Money Not null
);




