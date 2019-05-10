# 总结：
# 开始有三张表了
# 1、如果有两个外键，只创建一个外键的索引。看表是这样。还未验证
# 2、相关子查询。外部查询与子查询，相互依赖，相互影响。
# 例子5.5子查询where之后的and有点表链接的意思。
# 3、 5.6题了pull request
# 问题：
#为什么外键要创建索引？？？？？这个问题有待解答，我的猜想可能跟表链接效率有关。因为主键和外键，默认都会创建索引，主键创建的是唯一索引。
use sql_exercise;
show index from sql_exercise.Provides;
-- 5.1 Select the name of all the pieces.
select sql_exercise.Pieces.Name
from Pieces;
-- 5.2  Select all the providers' data.
select *
from Providers;
-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
select sql_exercise.Provides.Piece, avg(Price)
from Provides
group by Provides.Piece;
-- 5.4  Obtain the names of all providers who supply piece 1.
select b.Name
from Provides a
         join Providers b on a.Provider = b.Code
where a.Piece = 1;
#子查询也么问题。不过局说子查询性能不好。咱就不写了。也不是什么难事。
-- 5.5 Select the name of pieces provided by provider with code "HAL".
select b.Name
from Provides a
         join Pieces b on a.Piece = b.Code
where a.Provider = 'HAL';
#答案有个exists的例子  ---???这倒是一个没见过的写法
#子查询的where子句用到了另一个表的字段，这另一个表是在外部查询有出现的。
#这叫相关子查询，也有叫做同步查询 -- 外查询与子查询相互依赖，相互影响。
SELECT Name
FROM Pieces
WHERE EXISTS
          (
              SELECT *
              FROM Provides
              WHERE Provider = 'HAL'
                AND Piece = sql_exercise.Pieces.Code -- 这句话有点表链接的意思。链接了内外查询的两张表。骚操作。
          );
-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price
-- (note that there could be two providers who supply the same piece at the most expensive price).
-- ---------------------------------------------
select a.Name, b.Name, c.Price
from Pieces a
         join Providers b
         join Provides c on (a.Code = c.Piece and b.Code = c.Provider)
where c.Price in (select max(Provides.Price) from Provides group by Provides.Piece);

#这是答案，答案错了，已经提交pull request。
SELECT Pieces.Name, Providers.Name, Price
FROM Pieces
         INNER JOIN Provides ON Pieces.Code = Piece
         INNER JOIN Providers ON Providers.Code = Provider
WHERE Price =
      (
          SELECT MAX(Price)
          FROM Provides
          WHERE Piece = Pieces.Code
      );
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
insert Provides (Piece, Provider, Price) values (1,'TNBC',7);
-- 5.8 Increase all prices by one cent.
update Provides set Price =Price+1;
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
delete from Provides where Piece=4 and Provider='RBT';
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces
-- (the provider should still remain in the database).
delete from Provides where Provider='RBT';