-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

-- CREATE TABLE Manufacturers (
--   Code INTEGER,
--   Name VARCHAR(255) NOT NULL,
--   PRIMARY KEY (Code)   
-- );

-- CREATE TABLE Products (
--   Code INTEGER,
--   Name VARCHAR(255) NOT NULL ,
--   Price DECIMAL NOT NULL ,
--   Manufacturer INTEGER NOT NULL,
--   PRIMARY KEY (Code), 
--   FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
-- ) ENGINE=INNODB;

-- INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
-- INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
-- INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
-- INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
-- INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
-- INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
-- INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);


-- Select the names of all the products in the store.
select Name from Products;

-- Select the names and the prices of all the products in the store.
select name, price from products;

-- Select the name of the products with a price less than or equal to $200.
select name from products where price <= 200;
-- 
-- Select all the products with a price between $60 and $120.
select * from products where price between 60 and 120;
select * from products where price >= 60 and price <= 120;

-- Select the name and price in cents (i.e., the price must be multiplied by 100).
select name, price*100 from products;

select name, concat(price*100, ' cents') from products;

-- Compute the average price of all the products.
select avg(price) from products;
select sum(price)/count(price) from products;
 
-- Compute the average price of all products with manufacturer code equal to 2.
select avg(price) from products where  Manufacturer = 2;

-- Compute the number of products with a price larger than or equal to $180.
select count(*) from products where price>=180;

-- Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select name, price from products where price>=180 order by price desc, name asc;

-- Select all the data from the products, including all the data for each product's manufacturer.
select a.*, b.name from products a join Manufacturers b on(a.manufacturer = b.code);
select a.*, b.name from products a, Manufacturers b where a.manufacturer = b.code;

-- Select the product name, price, and manufacturer name of all the products.
select a.name, a.price, b.name from products a join Manufacturers b on(a.manufacturer = b.code);

SELECT Products.Name, Price, Manufacturers.Name
   FROM Products INNER JOIN Manufacturers
   ON Products.Manufacturer = Manufacturers.Code;

-- Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(Price), Manufacturer
    FROM Products
GROUP BY Manufacturer;



-- Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(a.price), b.name 
from Products a join Manufacturers b 
on a.manufacturer = b.code
group by b.name;

-- Select the names of manufacturer whose products have an average price larger than or equal to $150.
select avg(a.price), b.name 
from Manufacturers b join Products a 
on b.code = a.Manufacturer
group by b.name
having avg(a.price)>=150;

SELECT AVG(Price), Manufacturers.Name
   FROM Products, Manufacturers
   WHERE Products.Manufacturer = Manufacturers.Code
   GROUP BY Manufacturers.Name
   HAVING AVG(Price) >= 150;
   
   
-- Select the name and price of the cheapest product.
select name, price from Products 
where price = (
select min(price)
from products);

 SELECT name,price
  FROM Products
  ORDER BY price ASC
  LIMIT 1;

 SELECT Name, Price
   FROM Products
   WHERE Price = (SELECT MIN(Price) FROM Products);

-- Select the name of each manufacturer along with the name and price of its most expensive product.
select a.Name, max(a.price), b.Name
from Manufacturers b join Products a 
on a.Manufacturer = b.code
group by b.name;


 SELECT Products.Name, MAX(Price), Manufacturers.Name
 FROM Products, Manufacturers
 WHERE Manufacturer = Manufacturers.Code
 GROUP BY Manufacturers.Name;


-- Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products values (11, 'Loudspeakers', 70, 2);


-- Update the name of product 8 to "Laser Printer".
update products
set name = 'Laser Printer'
where code=8;

-- Apply a 10% discount to all products.
update products
set price=price*0.9;



-- Apply a 10% discount to all products with a price larger than or equal to $120.
update products
set price = price * 0.9
where price >= 120; 


