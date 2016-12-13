-- Used SQLite3 for this example

-- 10.1 Join table PEOPLE and ADDRESS, but keep only one address information for each person (we don't mind which record we take for each person). 
-- i.e., the joined table should have the same number of rows as table PEOPLE

SELECT
PEOPLE.id, PEOPLE.name, TEMP.address
FROM
PEOPLE
LEFT JOIN
(
SELECT id, MAX(address) as address 
FROM ADDRESS
GROUP BY id
)
AS TEMP
ON PEOPLE.id = TEMP.id; 


-- 10.2 Join table PEOPLE and ADDRESS, but ONLY keep the LATEST address information for each person. 
-- i.e., the joined table should have the same number of rows as table PEOPLE

SELECT
PEOPLE.id, PEOPLE.name, TEMP.address
FROM
PEOPLE
LEFT JOIN
(
SELECT id, address, MAX(updatedate)
FROM ADDRESS
GROUP BY id
)
AS TEMP
ON PEOPLE.id = TEMP.id; 

