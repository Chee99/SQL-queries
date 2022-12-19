Practice 2 

-- lIke and where clause 

Select BillingCountry from invoice where BillingCountry like 'B%'; --where billing country starts with B

Select distinct BillingCountry from invoice where BillingCountry like 'B%'; -- no dulicates 

Select title from album where title like '%the%';  -- contains the sequence 'the'
Select title from album where title like '_____the%'; --'the' is in the 6th postion
select FirstName, LastName from customer where FirstName like 'e%e'; --begins and ends with e
Select * from customer where city like '[est]%';   --starts with either e,s or t

select distinct BillingCity from invoice where BillingCity like 'B%' order by Billingcity --alphabetical ordewr starting with B
select distinct BillingCity, BillingCountry from invoice where BillingCountry like 'B%' order by Billingcity

---Operators - min,max,sum,avg,count, 
-- Scalar Aggregates - COUNT, MIN, MAX, SUM, AVG functions all return a single value as an output.

select * from Invoice 

select min(total) from invoice;

select FirstName from Customer where FirstName like 'e%'; --first name alphabetically starting with e
select min(FirstName) from Customer; -- the first name alphabetically

select max(Total) from Invoice;
select max(FirstName) from Customer -- the last first name alphabetically 

--Return the total amount spent by customer 2 from the Invoice table.
select sum(total) from invoice where customerid = 2;

select sum(Total) from invoice where BillingCountry like 'USA';

select avg(total) from Invoice where customerid = 2;
select avg(total) from invoice where BillingCountry like 'USA'; --avg total of of US in the invoice table 

select count(*) from invoice where Customerid =2; -- number of trascation done by customer 2
select count(BillingState) from invoice where billingstate is not null; --From Invoice table fetch the count of customers whose BillingState is not null. 

--logical operators - AND, OR and NOT 

--and Operator --The AND operator displays a record if all the conditions separated by the AND clause are TRUE
select * from invoice where BillingCountry like 'Germany' and total > 12; --invoice table where billing country is Germany and total is >12

select * from invoice where BillingCountry like 'USA' and total > 10 and BillingAddress like '%street%';

select * from customer where FirstName like 'M%' and LastName like '%P%S'; -- return record where customer first name start with M and last name cointains P and end with S

select * from invoice where BillingCountry like 'USA' or total > 10;

select * from invoice where BillingCountry like 'Germany' or  total < 5 or  BillingAddress like '%Ave%';

select * from customer where country like 'Germany' or country is not null or supportRepid = 3;

select * from invoice where not BillingCountry like 'USA';

select * from invoice where not billingcity like 'M%' order by billingcity; --Return all of the records from the invoice table for a customer where the Billing City is not 
--starting with an ‘M’ and order the results by Billing City.

select * from invoice where billingcountry not like 'USA' and billingcountry not like 'canada';

-- query above can be rewritten as 
select * from invoice where billingcountry not in('USA','Canada');

select * from customer where (firstname like 'L%' or lastname like '%A') and company is null;

select * from customer where (company is null) or country  like 'Brazil' and email not like '%gmail.com'; --Return all records from the customer table whose company is null. If a company is not null, 
--I also want those records back but only if their country is Brazil and they do not have a gmail.com email.

--#Update Clause 

update persons1 set city = 'Buffalo' where personsID = 1;

--Let’s update the city of the person with Address 3 to ‘NYC’
update persons1 set city = 'NYC' where Address = 'Address3';

update person1 set city = 'Boston', Address = '123 Drive'  where FirstName like 'F%' --update the city to Boston and address to 123 Drive if the person’s first name starts with an ‘F’.

update persons1 set city = 'Boston', Address = '123 Drive' where Lastname like 'L%' and not personsid in (2,5);  --Update the city to Boston and the Address to 123 Drive 
--if the person’s last name starts with an “L” and the person id is not 2 or 5.

--Delete Clause

Delete from Persons1 where PersonsID = 1;

Delete from Persons1 where FirstName like 'F%';  --delete everyone whose first name begins with the letter ‘F’

delete from persons1 where Firstname like '%M%' and not personsID in (1,4); --Delete the record if the person’s first name contains an ‘M’ but their person id is not 1 or 4.

--Vector Aggregates- This will return multiple values from an SQL query using a group by.

--Group BY Clause 

select BillingCountry, count(*)from Invoice group by BillingCountry; --What if we want to return the count of transactions from the invoice table by country

select Customerid, count(*) from Invoice group by Customerid;  --Return the number of transactions per customer from the invoice table. 

select Billingcountry, max(total) from Invoice group By Billingcountry;  --Return the max dollars spent per country from the invoice table.
 
--Having Clause -- The ‘HAVING’ clause with an aggregate function can work similarly to the ‘WHERE’ clause.
--It can be used to filter the records based on a given condition with ‘GROUP BY’

Select BillingCountry, sum(total) from Invoice group by BillingCountry having BillingCountry LIKE 'A%';

--Using the invoice table, return the count of transactions by billing countries that starts with a C or I 
--and the count of transactions is greater than 10.
Select BillingCountry, count(*) as transactions from Invoice group by BillingCountry having (BillingCountry LIKE 'C%' or BillingCountry LIKE 'I%') AND transactions > 10;

Select BillingState, sum(total) from Invoice group by BillingState having BillingState not null; --Return the sum total from the invoice table grouped by Billing State. 
--Make sure Billing State is not null.

--Round

Select BillingCity, max(total) from invoice group by billingcity; --Return the max total by billing city from the invoice table

Select BillingCity, round(max(total),1) from invoice group by billingcity; --Perform the same query above but round the max to 1 decimal place.


--Trunc -  Used to truncate valuses to a specified decimal - DOES NOT WORK IN Dbeaver

select Trunc(56.269);   - 56
select Trunc(56.269,1); - 56.3
select Trunc(56.269,2); - 56.27
select Trunc(56.269,-1); - 50

Select TRUNC(column, number of decimal) from table

--Length

select LastName, length(LastName) from Customer;

--Trim - Removes the leading trailing spaces  -- rtrim/ltrim - right and left spaces

delete from persons1;
insert into Persons1 Values ('001', '   Lname1Ag   ' , 'Fname1', 'Address1', 'city1');

select LastName, trim(LastName) from persons1; --Return the trimmed version of the Last Name.

--concat - combines the column specified into one - DOES NOT WORK IN DBEAVER
select concat(fname,lname) from customer; - FnameLname
select concat(fname,'',lname) from customer; - Fname Lname
select concat('Mr/s','',lname) from customer; - Mr/s Lname
select concat('SQL','is','fun!'); - SQL is fun!

--concat in Dbeaver

select Firstname||' '||Lastname from Customer; --Try combining First Name and Last Name separated by a space from the customer table.

--upper and lower CASE 

select upper(Firstname), lower(Lastname) from Customer; --Return all the First Names in caps, all last names lower case from the customer table;

--INSTR -- Searches a substring in a string and returns the starting position of the substring. If the substring does not exist, it will return a 0.

select title, INSTR(title, 'Manager') from employee;  --Return the starting position of the phrase ‘Manager’ in all of the titles from the employee table

--Substr -- This function will return a substring from a string starting at a specified position with a predefined length. 
--This is inclusive of the starting position, exclusive of the ending position.

select Title, Substr(title,3,5) from Employee; --Select the 3rd through the 7th character for the titles in the employee table. -- SELECT SUBSTR(string, start, length) 

--Replace -- Allows you to replace all occurrences of a specified string with another string.
-- This will not replace the underlying data in the table.--SELECT REPLACE(string, ‘string to replace’, ‘string to be replaced with’) from table

select Firstname, replace(Firstname,'Fname1', 'John') from persons1  --Replace the First Name in the persons1 table with ‘John’




