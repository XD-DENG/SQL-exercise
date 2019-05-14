#总结：
# 和练习五有点类似，也是用一个表去链接两个表。被链接的两个表之间，没有直接的联系。

use sql_exercise;

-- 6.1 List all the scientists' names, their projects' names,
-- and the hours worked by that scientist on each project,
-- in alphabetical order of project name, then scientist name.

#这个我感觉不难，题目说得紧张嘻嘻。
#答案用inner join我感觉不太合理啊。
#用left的join可能比较复合题目的意思。
#答案用inner join也可以。不会出现我当心的情况。（因为其他表有null字段参与链接，造成assignto行数据缺失。）
#因为assignto的链接是外键，所以其他两个表不会有null，造成缺失的情况。所以，inner join也没毛病。
select b.Name scientists, c.Name projects, c.Hours
from sql_exercise.AssignedTo a
         left join sql_exercise.Scientists b
                   on a.Scientist = b.SSN
         left join sql_exercise.Projects c on a.Project = c.Code order by c.Name,b.Name;


#答案
SELECT   S.Name, P.Name, P.Hours
FROM     Scientists S
         INNER JOIN AssignedTo A ON S.SSN=A.Scientist
         INNER JOIN Projects P ON A.Project=P.Code
ORDER BY P.Name ASC, S.Name ASC;

-- 6.2 Select the project names which are not assigned yet
select sql_exercise.Projects.Name from Projects where Code not in (select Project FROM AssignedTo);

#答案。没毛病。这种情况还真就是子查询了。表链接查询不好使。（虽说子查询基本能够用表链接查询代替。）
SELECT Name
FROM Projects
WHERE Code NOT In
(
SELECT Project
         FROM AssignedTo
);
