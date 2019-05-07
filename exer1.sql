SHOW DATABASES ; #显示所有数据库
SHOW VARIABLES LIKE 'PORT';#查看服务器监听端口
SHOW VARIABLES LIKE '%SECURE%';#查看SECURE_FILE_PRIV的值，这个值在做数据库数据导出的时候会用到

USE MYSQL;
SHOW TABLES ;#进入到某个数据库，显示数据库到所有表。

SELECT DATABASE();#当前选中数据库
SELECT USER();#当前用户;ROOT@218.66.48.229--用户名以及其客户端的HOST地址。


UPDATE user SET HOST = '%' WHERE USER='ROOT';
#表名是区分大小写的
#远程ROOT用户不能够登陆到数据库服务器到解决办法，就是允许所有到IP都可以远程登陆

select last_insert_id() ;#执行函数---select fun();

create database sql_exercise;
# use mysql;
# drop table mysql.Manufacturers;
#Cannot drop table 'Manufacturers' referenced by a foreign key constraint 'Products_ibfk_1' on table 'Products'
#表被依赖就删不掉，要先删除依赖表。
# drop table mysql.Products;

select * from sql_exercise.Manufacturers;#就算当前的数据库不是sql_exercise，通过schemas.obj全名来访问数据库对象。
select * from sql_exercise.Products;
select count(*)
from sql_exercise.Manufacturers;
show index from sql_exercise.Manufacturers;
show index from sql_exercise.Products;
