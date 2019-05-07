# 总结
# where 后的条件匹配:
# >=大于等于,=等于,
# between and 代表[]
# order by 后面用 ,逗号分割
-- 1.1 Select the names of all the products in the store.
select name from sql_exercise.Products;
-- 1.2 Select the names and the prices of all the products in the store.
select name,price from sql_exercise.Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
select name from sql_exercise.Products where Price <=200;
-- 1.4 Select all the products with a price between $60 and $120.
select * from sql_exercise.Products where Price between 60 and 120;#between and 是开闭区间还是闭区间？
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
#?
-- 1.6 Compute the average price of all the products.
select avg(sql_exercise.Products.Price) from sql_exercise.Products;#如何格式化输出呢？
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select avg(sql_exercise.Products.Price) from sql_exercise.Products where sql_exercise.Products.Manufacturer=2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
select count(*) from sql_exercise.Products where sql_exercise.Products.Price>=180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select sql_exercise.Products.Name,sql_exercise.Products.Price from sql_exercise.Products where sql_exercise.Products.Price>=180 order by sql_exercise.Products.Price desc  ,sql_exercise.Products.Name asc ;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from sql_exercise.Products
-- 1.11 Select the product name, price, and manufacturer name of all the products.
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
-- 1.15 Select the name and price of the cheapest product.
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
-- 1.18 Update the name of product 8 to "Laser Printer".
-- 1.19 Apply a 10% discount to all products.
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.