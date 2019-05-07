SHOW DATABASES ; #显示所有数据库
SHOW VARIABLES LIKE 'PORT';#查看服务器监听端口
SHOW VARIABLES LIKE '%SECURE%';#查看SECURE_FILE_PRIV的值，这个值在做数据库数据导出的时候会用到

USE MYSQL;
SHOW TABLES ;#进入到某个数据库，显示数据库到所有表。

SELECT DATABASE();#当前选中数据库
SELECT USER();#当前用户;ROOT@218.66.48.229--用户名以及其客户端的HOST地址。