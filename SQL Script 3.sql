--Practice 3 

---inner Join - Retrieves all the rows matching in both the tables
SELECT album.ArtistId,Title, Name from Album inner join Artist on Artist.artistid = Album.ArtistId;

select artist.ArtistId,Title, Name from Album inner join Artist on Artist.artistid = Album.ArtistId 
where Album.Title like '%disc%' order by artist.ArtistId;

--Alias -  another name we can refer to a column or table by      -- A2- Artist -- A1 - Album
select A2.ArtistId,Title, Name from Album A1 inner join Artist A2 on A2.artistid = A1.ArtistId;

select A2.ArtistId,Title, Name as 'Artist Name' from Album A1 inner join Artist A2 on A2.artistid = A1.ArtistId;

-- Cross Join - creates a cartesian product of rows from the tables joined
select artist.Artistid,Title,Name from Album CROSS JOIN Artist;

--inner join & Cross Join examples
--Return the Customer ID, Email, First Name, and Total for customers using both the customer and invoice tables.
select Customer.Customerid, Email, FirstName, Total from Customer inner join Invoice on Customer.Customerid = Invoice.Customerid;

--Return the CustomerID, Email, First Name, and Total for customers where the email contains “yahoo”
-- and their total is greater than $10. Use both the customer and invoice tables and sort the records in descending order of Total.
select customer.CustomerId, Email, Firstname, Total from Customer 
Inner Join Invoice on Customer.Customerid = Invoice.Customerid 
where email like '%yahoo%' and total > 10 order by Total desc;

--Write the SQL query for cross join of the Customer and Invoice tables bringing back the same columns as above.

select customer.CustomerId, customer.Email, customerFirstname, invoice.Total 
from Customer Cross Join Invoice 

--##Left Outer join - all info from left table and any matching info from right table
-- brings back all artist regardless if they have an album out(Album is null)
select artist.ArtistId, artist.Name, album.title from Album left join Artist on artist.ArtistId = album.ArtistId order by artist.Name

-- Right Outer join - all info from Right table and any matching info from left table 
select A1.ArtistId, A1.Name, A2.title from Artist A1 Right join Album A2 ON A1.Artistid = A2.Artistid order by A1.Name;

-- Self Joins -  join where the left and right table are the same
select e.Employeeid, e.firstname || ' ' || e.lastname as 'Direct report', m.EmployeeId, m.firstname || ' ' || m.lastname as 'Manager'from employee e 
inner join employee m ON m.employeeid = e.reportsto;

--full Outer join - Will return all the record from each table regardless of if there's a match or not 
select A1.ArtistId, A1.Name, A2.title from Artist A1 Full outer join Album A2 ON A1.Artistid = A2.Artistid order by Name;

-- we use Union for full Outer join
--Union All bring back everything from the both tables even if there are duplicates
select A1.ArtistId, A1.Name, A2.title from Artist A1 left join Album A2 ON A1.Artistid = A2.Artistid
Union ALL 
select A1.ArtistId, A1.Name, A2.title from Album A2 left join Artist A1 ON A1.Artistid = A2.Artistid order by Name;

--Union - removes duplicates
select A1.ArtistId, A1.Name, A2.title from Artist A1 left join Album A2 ON A1.Artistid = A2.Artistid
Union  
select A1.ArtistId, A1.Name, A2.title from Album A2 left join Artist A1 ON A1.Artistid = A2.Artistid order by Name;

--Except -  returns distinct rows from the left table that are not part of the right table
select ArtistId from Artist except select ArtistId from Album;

--Intersect - returns rows from the left table that are also part of the right table - same as inner join
--Return all of the Artist Ids that are contained in both the artist table and the album table.
select ArtistId from Artist Intersect select ArtistId from Album;

--case When Statement -- It compares an expression to a list of expressions to return the result.

-- case when statement that returns the CustomerId, First Name and Last Name concatenated as Full Name,
-- country, and a new column that contains the values of ‘Domestic’ if their country is in USA, ‘Neighbor’ if their country is Canada, 
--and ‘Foreign’ for any other country. Title the new column ‘CustomerGroup’.

select customerID, Firstname || ' ' || lastName as 'Full Name', country, 
case Country
when 'USA' THEN 'Domestic'
when 'Canada' then 'Neighbor'
Else 'Foreign'
end CustomerGroup
from Customer;

select customerid, Firstname || ' ' || lastName as 'Full Name', country, 
case 
when country in ('USA','Canada') THEN 'Domestic'
Else 'Foreign'
end CustomerGroup
from Customer;


--lIMIT - constraints the number of rows returned by the QUERY 
select * from customer limit 5;  --Write a query that returns all information for the first 5 customers.

--Rank --  assign a rank to each row in a query result set
select BillingCountry, BillingCity, total, rank() over (order by total) as total_Rank from Invoice;

select BillingCountry, BillingCity, total, rank() over (order by total desc) as total_Rank from Invoice;

--Group Rank-RANK WITHIN A SET OF GROUPS
--Write a query that ranks the totals from the invoice table within each country. Return the columns Billing Country, City, Total and their rank.
select BillingCountry, BillingCity, total, rank() over(partition by BillingCountry order by total) from Invoice;

--Dense Rank- Assigns a rank to each of the queries output
select BillingCountry, BillingCity, total, dense_rank() over(order by total) as total_Rank from Invoice;

select BillingCountry, BillingCity, total, dense_rank() over(partition by BillingCountry order by total) from Invoice;

--Row Number - assigns a sequential interger to each row of the queries result set
--Write a query to number the row of each customer in alphabetical order with a name beginning with ‘A’ first. 
select row_number()over (order by FirstName)as Row_num, FirstName from Customer;

select row_number()over (Partition by Country order by Firstname) as Row_num, FirstName, country from Customer;

--Date & Date Time
SELECT DATE('NOW');
SELECT DATETIME('NOW');
SELECT DATETIME('NOW','LOCALTIME');

--Date Math
SELECT DATE('NOW', '+5 months');
SELECT DATE('2019-05-01','+5 years');
SELECT DATE('NOW', '-30 days');

--Arthmetric Function 
select total, 
total + 1 as Total1,
total - 2 as Total2,
total * 2 as Total3,
total / 2 as Total4,
power(total,2) as total5,
SQRT(TOTAL) as total6
from invoice;

--Lead -- access the data of the following row at the given physical offset from the current row.
Select Customerid,InvoiceDate,Total, lead(total,1,0) over (partition by Customerid) as NextTotal from Invoice order by Customerid, invoiceDate, Total;

-- access the data of the second row down from your current row based on the Invoice data. 
--If there is no data, have it return an ‘NA’. Order the final output by CustomerId, Invoice Date, and Total.
Select Customerid,InvoiceDate,Total, lead(total,2,'NA') over (partition by Customerid) as NextTotal from Invoice order by Customerid, invoiceDate, Total;

--Lag - access the data from previous rows
Select Customerid,InvoiceDate,Total, lag(total,1,0) over (partition by Customerid) as PrevTotal from Invoice order by Customerid, invoiceDate, Total;

--Coalesce - substitiute default value for a null value
--Write a query that returns the word ‘missing’ if Billing Country is null.
select BillingCountry, Coalesce(BillingCountry,'missing') from Invoice; 

 --replace with anoter Column
select BillingCountry, Coalesce(BillingCountry,BillingState) from Invoice;

--IF NULL -- Similar to Coalesce
select BillingCountry, BillingState, IFNULL(BillingState,BillingCountry) from Invoice;

--IIF -- similar to how case works
--Return CustomerID, FirstName, Country, and a new column titled ‘Customer Group’ which contains the value ‘Domestic’ if the country is USA 
--and ‘Foreign’ for all other values.
select CustomerID, FirstName, Country, IIF(Country like 'USA', 'Domestic', 'Foreign')as CustomerGroup from Customer;

--NULLIF -- if the argument is equal to the first argument, NULLIF will return NULL else first argument
--Return Billing state and if Billing state is equal to California, then return a null value
select billingstate, Nullif(BillingState,'CA') from Invoice;

--Subqueries --nested select statement within another select statement 
select trackid,name, albumid from track where albumid in (select albumid from Album where title like 'Let there be Rock');

-- can use join to complete the same query above
select trackid, name, track.AlbumId
from track join album 
on track.albumid = album.albumid 
where title = 'Let there be Rock';

select customerid, firstname || ' ' || lastname as name,state, Country 
from Customer where Customerid in (select Customerid from Invoice where Billingstate like 'N%');

--Exists --The EXISTS operator is a logical operator that checks whether a subquery returns any row.
--returns true or false

SELECT c.CustomerId, c.FirstName, c.LastName
FROM Customer c
WHERE EXISTS 
     (SELECT 1 FROM Invoice i
     WHERE i.CustomerId = c.CustomerId And substr(i.InvoiceDate,1,4) = '2008' ) ORDER BY c.FirstName, c.LastName; 


