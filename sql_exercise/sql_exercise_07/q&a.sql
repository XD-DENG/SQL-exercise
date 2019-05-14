#这应该是个快递模型
#尝试下，能不能通过表的diagrams图来写出sql语句。
#总结，sql中的转义是   '
#这一节，有5个表，吓死人，但是练习题就两题，不仅少，而且简单。
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
use sql_exercise;
select c.Name
from Package p join Client c on p.Recipient = c.AccountNumber where p.Weight=1.5;

#答案
select Client.name
from Client join Package
on Client.AccountNumber = Package.Recipient
where Package.Weight = 1.5;
# 没毛病

-- 7.2 What is the total weight of all the packages that he sent?

select sum(p.Weight)
from Package p join Client c on p.Sender = c.AccountNumber where c.Name='Al Gore''s Head';

#答案
SELECT SUM(p.weight)
FROM Client AS c
  JOIN Package p
  ON c.AccountNumber = p.Sender
WHERE c.Name = "Al Gore's Head";