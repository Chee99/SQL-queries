-- practice 1--

create table Persons (
PersonsID INT,          --integer
LastName varchar(255),  ---Character 
FirstName varchar(255),
Address varchar(255),
city varchar(50),
state varchar(20)
);

DROP table Persons;

 --Primary Keys 


create table Persons (
PersonsID INT NOT NULL,        -- can't be null
LastName varchar(255) NOT NULL,
FirstName varchar(255),
Address varchar(255),
city varchar(50),
state varchar(20),
primary key (PersonsID) --can't be duplicated, identifer 
);

--Foreign within a table that is primary key in another table

create table orders (
OrderID int NOT NULL,
OrderNum int NOT NULL,
PersonID int,
primary key (OrderID),
Constraint FK_PersonOrder Foreign key (PersonID) References Persons(PersonID)   
);

create table orders (
OrderID int NOT NULL,
OrderNum int NOT NULL,
PersonsID int,
LastName varchar(255),
primary key (OrderID),
Constraint FK_PersonOrder Foreign key (PersonsID,LastName)
References Persons(PersonsID, LastName));

--Select from table 

create table Persons1 AS 
select * from Persons      --select the whole table 

DROP table Persons;

create table Persons2 AS 
select PersonsID,LastName from Persons;

--modify tables

Alter table persons add Email varchar(255);

Alter table persons drop column Email;


Alter table persons modify column Email varchar(50); --error

Alter table persons rename column Email to email; 

--adding rows
insert into persons values ('001', 'LName', 'FName','Address1','Buffalo', 'NY', 'abc@gmail.com');

insert into Persons(personsID, LastName, FirstName, Address) values('002','LName','FName','Address1'); 

--wont work because primary key is not shown
insert into Persons(LastName, FirstName, Address, city) Values('LastName', 'FirstName', 'Address', 'city');

--a way around it - Autoincrement -- allows a unique number to be generated automatically when a new record is inserted into a table.

create table Persons(
PersonsID integer primary key autoincrement,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
city varchar(50),
state varchar(20),
Email varchar(50),
DOB Date
);

insert into Persons(LastName, FirstName, Address, city) Values('LastN1', 'First2', 'Address3', 'city4');
 
--set default

DROP table Persons;

create table Persons (
PersonsID integer primary key autoincrement,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
city varchar(255) DEFAULT 'New York',
Email varchar(50),
DOB Date
);

create table Persons (
PersonsID integer primary key autoincrement,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
city varchar(255) NOT NULL CHECK(CITY IN ("Buffalo","Syracuse")),
Email varchar(50),
DOB Date
);

--Select and order

 select* from Invoice;
 select CustomerId, BillingCity from Invoice;

--#sorting
select CustomerId, BillingCity from Invoice order by BillingCity; --alphabetical order interms of Billingcity A-Z

select CustomerId, BillingCity from Invoice order by BillingCity desc; --highest to lowest order Z-A

--unique record -eliminate duplicate record 

select DISTINCT BillingCity from invoice;
select Distinct country from Customer;

--conditonal queries

select * from Invoice where CustomerID = '2';
select AlbumId, Title, ArtistId from Album where ArtistId = '1';
select*from Invoice where total < 5;
select * from Customer where SupportRepID <= 4;

--where and Between
select * from Invoice where total not between 1.98 and 5;
select * from Invoice where BillingCountry in ('Brazil', 'France');
select * from Invoice where BillingCountry not in ('Brazil', 'France');















