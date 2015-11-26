-- The Warehouse
-- lINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_warehouse


-- Select all warehouses.
select * from warehouses;

-- Select all boxes with a value larger than $150.
select * from boxes where Value>150;

-- Select all distinct contents in all the boxes.
select distinct contents from boxes;

-- Select the average value of all the boxes.
select avg(value) from boxes;

-- Select the warehouse code and the average value of the boxes in each warehouse.
select warehouse, avg(value) from boxes group by warehouse;

SELECT Warehouse, AVG(Value)
    FROM Boxes
GROUP BY Warehouse;

-- Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select warehouse, avg(value) 
from boxes 
group by warehouse
having avg(value)> 150;

-- 
-- Select the code of each box, along with the name of the city the box is located in.
select boxes.code, warehouses.location
from boxes join warehouses
on boxes.Warehouse = Warehouses.Code;

SELECT Boxes.Code, Location
      FROM Warehouses 
INNER JOIN Boxes ON Warehouses.Code = Boxes.Warehouse;

-- 
-- Select the warehouse codes, along with the number of boxes in each warehouse. 
-- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
select Warehouse, count(*) 
from boxes 
group by warehouse;


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
select Code
from warehouses join (select warehouse temp_a, count(*) temp_b from boxes group by warehouse) temp
on (warehouses.code = temp.temp_a)
where warehouses.Capacity<temp.temp_b;


SELECT Code
   FROM Warehouses
   WHERE Capacity <
   (
     SELECT COUNT(*)
       FROM Boxes
       WHERE Warehouse = Warehouses.Code
   );



-- Select the codes of all the boxes located in Chicago.


select Boxes.code 
from boxes join Warehouses
on boxes.warehouse = warehouses.code
where warehouses.location = 'Chicago';

/* Without subqueries */
 SELECT Boxes.Code
   FROM Warehouses LEFT JOIN Boxes
   ON Warehouses.Code = Boxes.Warehouse
   WHERE Location = 'Chicago';

 /* With a subquery */
 SELECT Code
   FROM Boxes
   WHERE Warehouse IN
   (
     SELECT Code
       FROM Warehouses
       WHERE Location = 'Chicago'
   );

-- Create a new warehouse in New York with a capacity for 3 boxes.
insert into Warehouses (Location, capacity) values ('New fdaYork', 9);


-- 
-- Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes
   VALUES('H5RT', 'Papers', 200, 2);

-- Reduce the value of all boxes by 15%.
update boxes
set value = value * 0.85;


-- Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.
-- 
--  this solution doesn't work with mysql 5.0.67
--  ERROR 1093 (HY000): You can't specify target table 'Boxes' for update in FROM clause


-- Remove all boxes with a value lower than $100.
delete from boxes 
where value < 100;

-- 
-- Remove all boxes from saturated warehouses.

