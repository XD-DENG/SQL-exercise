# 总结
# 1、where 后的条件匹配:
# >=大于等于,=等于,
# between and 代表[]=闭区间
# 2、order by 后面用 ,逗号分割
# 3、表的链接查询，通常通过外键链接a.Manufacturer=b.Code，通过left，right,inner join来限定链接结果。
# 4、group by的条件筛选是having而不是where
# 5、在where条件中使用min()提示invalid use of group function。where中不能使用聚合函数（也叫列函数）的原因
# 6、查询最大或最小 a)子查询；b)排序后，限制查询结果数为1
# 7、from后面多个表相当于inner join。原先的on由where代替
# 8、 on 后面多个条件用 and 链接
# 9、查询语句表是在from后面，insert，update ,delete 表都是首当其冲
# 10、update是一行行更新的。也能通过order by来指定更新的顺序==update tableName set balance = 'value' order by create_time;
-- 1.1 Select the names of all the products in the store.
select name from sql_exercise.Products;
-- 1.2 Select the names and the prices of all the products in the store.
select name,price from sql_exercise.Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
select name from sql_exercise.Products where Price <=200;
-- 1.4 Select all the products with a price between $60 and $120.
select * from sql_exercise.Products where Price between 60 and 120;#between and 是闭区间
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select name,price*100 as cents from sql_exercise.Products;
-- 1.6 Compute the average price of all the products.
select avg(sql_exercise.Products.Price) from sql_exercise.Products;#如何格式化输出呢？
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(sql_exercise.Products.Price) from sql_exercise.Products where sql_exercise.Products.Manufacturer=2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) from sql_exercise.Products where sql_exercise.Products.Price>=180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select sql_exercise.Products.Name,sql_exercise.Products.Price from sql_exercise.Products where sql_exercise.Products.Price>=180 order by sql_exercise.Products.Price desc  ,sql_exercise.Products.Name asc ;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select a.*,b.* from sql_exercise.Products a left join sql_exercise.Manufacturers b on a.Manufacturer=b.Code;#外键用来链接表，a.Manufacturer=b.Code这个就是具体的链接脚本。之于链接结果通过left，right，或inner join来限定
-- 1.11 Select the product name, price, and manufacturer name of all the products.
select a.name,a.price,b.name from sql_exercise.Products a left join sql_exercise.Manufacturers b on a.Manufacturer = b.Code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.  ***用到了group by和聚合函数
select b.code,avg(a.Price) from sql_exercise.Products a left join sql_exercise.Manufacturers b on a.Manufacturer=b.Code group by b.code;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select b.Name,avg(a.Price) from sql_exercise.Products a left join sql_exercise.Manufacturers b on a.Manufacturer=b.Code group by b.code;
-- 1.14 *****Select the names of manufacturer whose products have an average price larger than or equal to $150.
select b.Name ,avg(a.Price) from sql_exercise.Products  a   join sql_exercise.Manufacturers b on a.Manufacturer=b.Code group by b.Code having avg(a.Price)>=150;#这是正确答案用join而不是我用left join
# 这是一个与此题无关的脚本，它举例了having的意义：对'结果集'的'统计数据'的'筛选'。一般与group by一起使用。相当于对各个group的结果集进行统计，筛选。如果不用group by相当于对整个结果集（就是一个分组）进行筛选。
select avg(a.Price) from sql_exercise.Products  a   join sql_exercise.Manufacturers b on a.Manufacturer=b.Code  having avg(a.Price)>=10;

-- 1.15 Select the name and price of the cheapest product.#要用子查询
# 子查询
select sql_exercise.Products.Name,sql_exercise.Products.Price from sql_exercise.Products where Price=(select min(sql_exercise.Products.Price) from sql_exercise.Products);
# 升序后， 限制查询条数为1
select sql_exercise.Products.Name,sql_exercise.Products.Price from sql_exercise.Products order by Price limit 1;#sqlserver top 1
-- 1.16 ***** Select the name of each manufacturer along with the name and price of its most expensive product.

#我觉得我的解法更好
#1、找到所有工厂最贵的产品集合
# 2、在所有产品里选出价格在最贵产品集合里的产品
# 3、通过表链接，增加显示产品工厂的厂家名称
# 其实关键在第二步就差不多解决了
select b.Name as manufacturerName,a.Name as productName,a.Price from
(select * from sql_exercise.Products where Price in (select max(Price) from sql_exercise.Products group by Manufacturer) ) a join sql_exercise.Manufacturers b on a.Manufacturer=b.Code;

#答案
select max_price_mapping.name as manu_name, max_price_mapping.price, products_with_manu_name.name as product_name
from
    (SELECT sql_exercise.Manufacturers.Name, MAX(Price) price
     FROM sql_exercise.Products, sql_exercise.Manufacturers
     WHERE Manufacturer = Manufacturers.Code
     GROUP BY Manufacturers.Name)-- 表链接 查出各个工厂的最贵产品 以及工厂名用于下一步链接
     as max_price_mapping
   left join
     (select sql_exercise.Products.*, sql_exercise.Manufacturers.Name manu_name
      from sql_exercise.Products join sql_exercise.Manufacturers
      on (sql_exercise.Products.manufacturer = sql_exercise.Manufacturers.code))-- 表链接 取出工厂名用于下一步链接
      as products_with_manu_name
 on
   (max_price_mapping.name = products_with_manu_name.manu_name
    and
    max_price_mapping.price = products_with_manu_name.price);#这里的on链接有点看不懂。?????

-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into sql_exercise.Products set sql_exercise.Products.Name='Loudspeakers',Price='70',Manufacturer=2,Code=11;
-- 1.18 Update the name of product 8 to "Laser Printer".
update sql_exercise.Products
set Name = 'Laser Printer'
where Code=8;
-- 1.19 ******Apply a 10% discount to all products.
update sql_exercise.Products
set Price = Price * 0.9;
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
update sql_exercise.Products
set Price = Price * 0.9
where Price>=120;