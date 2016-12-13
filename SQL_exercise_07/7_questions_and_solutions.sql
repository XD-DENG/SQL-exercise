-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 

-- 7.1
-- Who receieved a 1.5kg package?
select Recipient from Package where Weight = 1.5;

select client.name 
from client join Package
on client.AccountNumber = Package.Recipient
where package.Weight = 1.5;


SELECT Client.Name
FROM Client JOIN Package   
  ON Client.AccountNumber = Package.Recipient 
WHERE Package.weight = 1.5;
-- The result is "Al Gore's Head".


-- 7.2
-- What is the total weight of all the packages that he sent?
select sum(weight) from Package 
where Sender = (
select Recipient from Package where Weight = 1.5
);

SELECT SUM(p.weight) 
FROM Client AS c 
  JOIN Package as P 
  ON c.AccountNumber = p.Sender
WHERE c.Name = "Al Gore's Head";
