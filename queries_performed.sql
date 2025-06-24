-- List All Tables in the Database
SELECT name FROM sqlite_master WHERE type='table';

-- Check Table Structure (Schema)
PRAGMA table_info(Album);
PRAGMA table_info(Artist);
PRAGMA table_info(Customer);
PRAGMA table_info(Employee);
PRAGMA table_info(Genre);
PRAGMA table_info(Invoice);
PRAGMA table_info(InvoiceLine);
PRAGMA table_info(MediaType);
PRAGMA table_info(Playlist);
PRAGMA table_info(PlaylistTrack);
PRAGMA table_info(Track);

-- See sample data
SELECT * FROM Album LIMIT 5;
SELECT * FROM Customer LIMIT 5;
SELECT * FROM Artist LIMIT 5;
SELECT * FROM Customer LIMIT 5;
SELECT * FROM Employee LIMIT 5;
SELECT * FROM Genre LIMIT 5;
SELECT * FROM Invoice LIMIT 5;
SELECT * FROM InvoiceLine LIMIT 5;
SELECT * FROM MediaType LIMIT 5;
SELECT * FROM Playlist LIMIT 5;
SELECT * FROM Track LIMIT 5;

-- List all countries where customers are from:
SELECT DISTINCT Country FROM Customer;

-- Count number of customers per country:
SELECT Country, COUNT(*) AS total_customers
FROM Customer
GROUP BY Country
ORDER BY total_customers DESC;

-- List all genres available:
SELECT * FROM Genre;

-- Top 10 most expensive tracks
SELECT Name, UnitPrice
FROM Track
ORDER BY UnitPrice DESC
LIMIT 10;


-- Join two tables to see relationship
SELECT c.FirstName, i.InvoiceDate, i.Total
FROM Customer c
JOIN Invoice i ON c.CustomerId = i.CustomerId
LIMIT 5;

-- Total revenue generated
SELECT SUM(Total) AS total_revenue FROM Invoice;

-- Total revenue generated per country:
SELECT BillingCountry, SUM(Total) AS Revenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;

-- Top 5 best-selling tracks
SELECT t.Name, COUNT(il.TrackId) AS TimesSold
FROM InvoiceLine il
JOIN Track t ON il.TrackId = t.TrackId
GROUP BY il.TrackId
ORDER BY TimesSold DESC
LIMIT 5;
 
--  Average order amount per customer
SELECT c.FirstName || ' ' || c.LastName AS CustomerName,
       AVG(i.Total) AS AvgInvoiceAmount
FROM Invoice i
JOIN Customer c ON i.CustomerId = c.CustomerId
GROUP BY c.CustomerId
ORDER BY AvgInvoiceAmount DESC
LIMIT 10;


-- Top 5 customers by spending
SELECT Customer.FirstName || ' ' || Customer.LastName AS CustomerName,SUM(Invoice.Total) AS AmountSpent
FROM Customer
JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY AmountSpent DESC
LIMIT 5;

-- Monthly revenue report
SELECT strftime('%Y-%m', InvoiceDate) AS Month,
       SUM(Total) AS Revenue
FROM Invoice
GROUP BY Month
ORDER BY Month;

--  Revenue classification (CASE statement):
SELECT BillingCountry,
       SUM(Total) AS Revenue,
       CASE
           WHEN SUM(Total) > 100 THEN 'High'
           WHEN SUM(Total) > 50 THEN 'Medium'
           ELSE 'Low'
       END AS RevenueClass
FROM Invoice
GROUP BY BillingCountry
ORDER BY Revenue DESC;

