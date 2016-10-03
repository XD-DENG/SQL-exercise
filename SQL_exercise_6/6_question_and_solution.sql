-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists

-- 6.1
-- List all the scientists' names, their projects' names, 
-- and the hours worked by that scientist on each project, 
-- in alphabetical order of project name, then scientist name.

SELECT   S.Name, P.Name, P.Hours
FROM     Scientists S 
         INNER JOIN AssignedTo A ON S.SSN=A.Scientist
         INNER JOIN Projects P ON A.Project=P.Code
ORDER BY P.Name ASC, S.Name ASC;

-- 6.2
-- Select the project names which are not assigned yet
SELECT Name 
FROM Projects
WHERE Code NOT In
(
SELECT Project 
         FROM AssignedTo
);


