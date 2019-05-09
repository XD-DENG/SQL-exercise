# 总结：
# 1、进行了表链接查询时，如果给表取了别名。那么select子句要用链接表的别名，用schemas全名都是不可以的。注意了-详见本页3.7
#   取了别名都用别名，包括on后面的
#     还有个不能用全名的是在删除表的外键的时候。详见本页3.18例子
# 2、索引的创建,索引创建在表的列上
# 3、删除索引-索引列如果是外键可能删不掉。-Cannot drop index 'INDEX_WAREHOUSE': needed in a foreign key constraint
#     要先删除外键约束。
# 4、mysql中 外键列会自动创建索引，索引的名字就是列名
use sql_exercise;
show columns from sql_exercise.Boxes;
show columns from sql_exercise.Warehouses;
show index from sql_exercise.Boxes;
show index from sql_exercise.Employees;
show index from sql_exercise.Products;
select * from sql_exercise.Boxes;
-- 3.1 Select all warehouses.
-- 3.2 Select all boxes with a value larger than $150.
select * from Boxes where Value>150;
-- 3.3 Select all distinct contents in all the boxes.
select Contents from sql_exercise.Boxes group by Contents;
#答案
select distinct contents from sql_exercise.Boxes;
-- 3.4 Select the average value of all the boxes.
select avg(Value) from sql_exercise.Boxes;
-- 3.5 Select the warehouse code and the average value of the boxes in each warehouse.
select sql_exercise.Boxes.Warehouse,avg(sql_exercise.Boxes.Value) from sql_exercise.Boxes group by Warehouse;
-- 3.6 Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
select sql_exercise.Boxes.Warehouse,avg(sql_exercise.Boxes.Value) from sql_exercise.Boxes group by Warehouse having avg(Value)>150;
-- 3.7 Select the code of each box, along with the name of the city the box is located in.
select a.Code,b.Location as cityName from sql_exercise.Boxes a,sql_exercise.Warehouses  b where a.Warehouse=b.Code;
#下面这句是不行的。不行在select的子句，会报找不到。
#表链接用了别名，select子句要通过别名进行访问。如果还用schemas全名进行访问是不行的。
#如果没有用别名，select 子句用schemas.tableName全名是没有问题的。
select sql_exercise.Boxes.Code,sql_exercise.Warehouses.Location as cityName from sql_exercise.Boxes a,sql_exercise.Warehouses  b where a.Warehouse=b.Code;
select sql_exercise.Boxes.Code,sql_exercise.Warehouses.Location as cityName from sql_exercise.Boxes ,sql_exercise.Warehouses  where sql_exercise.Boxes.Warehouse=sql_exercise.Warehouses.Code;

-- 3.8 Select the warehouse codes, along with the number of boxes in each warehouse.
select  Warehouse,count(*) from Boxes group by Warehouse;
    -- Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).?????
-- 3.9 Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).

select * from (select  Warehouse,count(*) as realCount from Boxes group by Warehouse) a join Warehouses b on a.Warehouse=b.Code where a.realCount>b.Capacity;
#答案（与答案一个思路）
select Code
from Warehouses join (select Warehouse temp_a, count(*) temp_b from Boxes group by warehouse) temp
on (Warehouses.code = temp.temp_a)
where Warehouses.Capacity<temp.temp_b;
#答案-这是另一个思路
SELECT Code
   FROM Warehouses
   WHERE Capacity <
   (
     SELECT COUNT(*)
       FROM Boxes
       WHERE Warehouse = Warehouses.Code
   );

-- 3.10 Select the codes of all the boxes located in Chicago.
#子查询思路
select sql_exercise.Boxes.Code from sql_exercise.Boxes where Warehouse in (select sql_exercise.Warehouses.Code from sql_exercise.Warehouses where sql_exercise.Warehouses.Location='Chicago');
#表链接也是一种思路
select Boxes.code
from Boxes join Warehouses
on Boxes.warehouse = Warehouses.code
where Warehouses.location = 'Chicago';
-- 3.11 Create a new warehouse in New York with a capacity for 3 boxes.
insert Warehouses (Code, Location, Capacity) values (6,'New York',3);
-- 3.12 Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
insert Boxes (Code, Contents, Value, Warehouse) VALUES ('H5RT','Papers',200,2);
-- 3.13 Reduce the value of all boxes by 15%.
update Boxes set Value =Value*0.85 where 1=1;

-- 3.14 Remove all boxes with a value lower than $100.
#懒得写
-- 3.15 Remove all boxes from saturated warehouses.
delete from Boxes where Warehouse in ( select Code from Warehouses a join ( select Warehouse, count(*) as realCount from Boxes group by Warehouse) b on a.Code=b.Warehouse where a.Capacity<b.realCount);
#答案-思路稍有不同
delete from Boxes
where warehouse in
(
SELECT Code
   FROM Warehouses
   WHERE Capacity <
   (
     SELECT COUNT(*)
       FROM Boxes
       WHERE Warehouse = Warehouses.Code
   )
);
-- 3.16 Add Index for column "Warehouse" in table "boxes"
    -- !!!NOTE!!!: index should NOT be used on small tables in practice
    CREATE INDEX INDEX_WAREHOUSE ON Boxes (warehouse);

-- 3.17 Print all the existing indexes
    -- !!!NOTE!!!: index should NOT be used on small tables in practice


-- MySQL
SHOW INDEX FROM Boxes FROM sql_exercise;
SHOW INDEX FROM sql_exercise.Boxes;

# -- SQLite
# .indexes Boxes
# -- OR
# SELECT * FROM SQLITE_MASTER WHERE type = "index";
#
# -- Oracle
# select INDEX_NAME, TABLE_NAME, TABLE_OWNER
# from SYS.ALL_INDEXES
# order by TABLE_OWNER, TABLE_NAME, INDEX_NAME


-- 3.18 Remove (drop) the index you added just
    -- !!!NOTE!!!: index should NOT be used on small tables in practice

ALTER TABLE sql_exercise.Boxes DROP FOREIGN KEY Boxes_ibfk_1 ;
# ALTER TABLE sql_exercise.Boxes DROP FOREIGN KEY sql_exercise.Boxes.Boxes_ibfk_1 ;
# -- 这样写是不可以的，不能sql_exercise.Boxes.Boxes_ibfk_1  只能Boxes_ibfk_1
drop index INDEX_WAREHOUSE on sql_exercise.Boxes;
#Cannot drop index 'INDEX_WAREHOUSE': needed in a foreign key constraint