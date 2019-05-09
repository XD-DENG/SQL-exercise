# 总结
# 1、distinct 对null有效
# 2、是否为null用is null，而不是=null
# 3、这一节开始有null 的出现
# 4、not in 判断是否在集合内，这个集合必须没有null。否者不行。in好像没毛病
#    答案原话-- the query below would FAIL due to the NULL value returned by the subquery
#     请看本页4.7例子
# 链接查询比子查询性能好。局说是因为临时表的原因。

# 5、where movies 相当于 where movies is not null;发现新大陆。
use sql_exercise;
select * from MovieTheaters;

-- 4.1 Select the title of all movies.
select Title
from Movies;
-- 4.2 Show all the distinct ratings in the database.
select distinct Rating from Movies;#null也会进行distinct，即只选一个null
-- 4.3  Show all unrated movies.
select * from Movies where Rating is null;# null 是不能用等号的。用 is null
-- 4.4 Select all movie theaters that are not currently showing a movie.
select *
from MovieTheaters where Movie is null;
-- 4.5 Select all data from all movie theaters
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
#左链接的例子
#答案已经校对，右链接一样的道理
select a.*,b.*
from MovieTheaters a left join Movies b on a.Movie = b.Code;
-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
#答案已经校对，右链接一样的道理
select a.*,b.* from Movies a left join  MovieTheaters b on a.Code = b.Movie;
-- 4.7 *****Show the titles of movies not currently being shown in any theaters.
#答案已经比对。正确。
#子查询
select * from Movies where Code not in (select Movie from MovieTheaters where Movie);#where Movie == where Movie is not null;
#子查询要剔除null，否者不行。注意咯*******
#join
select * from Movies a left join MovieTheaters b on a.Code = b.Movie where b.Movie is null;
select *
from MovieTheaters a ;
-- 4.8 Add the unrated movie "One, Two, Three".
insert Movies(Code,Title, rating) values (9,'One,Two,Three',null);#答案做得不对。
-- 4.9 Set the rating of all unrated movies to "G".
update Movies
set Rating = 'G'
where Rating is null;
-- 4.10 Remove movie theaters projecting movies rated "NC-17".
#子查询
delete from MovieTheaters where Movie in (select Code from Movies where Rating='NC-17');
#表链接
# 这用表链接，还真不咋地，答案没用表链接。