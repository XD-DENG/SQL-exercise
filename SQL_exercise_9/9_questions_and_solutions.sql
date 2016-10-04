-- 9.1 give the total number of recordings in this table
SELECT 
    COUNT(*)
FROM
    cran_logs_2015_01_01;

-- 9.2 the number of packages listed in this table?
SELECT 
    COUNT(DISTINCT package)
FROM
    cran_logs_2015_01_01;

-- 9.3 How many times the package "Rcpp" was downloaded?
SELECT 
    COUNT(*)
FROM
    cran_logs_2015_01_01
WHERE
    package = 'Rcpp';

-- 9.4 How many recordings are from China ("CN")?
SELECT 
    COUNT(*)
FROM
    cran_logs_2015_01_01
WHERE
    country = 'CN';

-- 9.5 Give the package name and how many times they're downloaded. Order by the 2nd column descently.
SELECT 
    package, COUNT(*)
FROM
    cran_logs_2015_01_01
GROUP BY package
ORDER BY 2 DESC;

-- 9.6 Give the package ranking (based on how many times it was downloaded) during 9AM to 11AM
select a.package, count(*) 
from 
(select * from cran_logs_2015_01_01 
	where 
		substr(time, 1, 5)<"11:00" 
        and 
        substr(time, 1, 5)>"09:00")
as a
group by a.package 
order by 2 desc;

-- 9.7 How many recordings are from China ("CN") or Japan("JP") or Singapore ("SG")?
--    Select based on a given list.
SELECT 
    COUNT(*)
FROM
    cran_logs_2015_01_01
WHERE
    country = 'CN' 
    OR country = 'JP'
	OR country = 'SG';
    
SELECT 
    COUNT(*)
FROM
    cran_logs_2015_01_01
WHERE
    country IN ('CN' , 'JP', 'SG');


-- 9.8 Print the countries whose downloaded are more than the downloads from China ("CN")

SELECT 
    TEMP.country
FROM
    (SELECT 
        country, COUNT(*) AS downloads
    FROM
        cran_logs_2015_01_01
    GROUP BY country) AS TEMP
WHERE
    TEMP.downloads > (SELECT 
            COUNT(*)
        FROM
            cran_logs_2015_01_01
        WHERE
            country = 'CN');

-- 9.9 Print the average length of the package name of all the UNIQUE packages

-- Wrong Solution (missed "UNIQUE")
SELECT AVG(LENGTH(package)) from cran_logs_2015_01_01;

-- Correct Solution
SELECT AVG(LENGTH(temp.packages)) 
FROM 
(
SELECT DISTINCT package as packages
	FROM cran_logs_2015_01_01
) temp;


-- 9.10 Get the package whose downloading count ranks 2nd (print package name and it's download count).

SELECT temp.a package, temp.b count
FROM
(
SELECT package a, count(*) b
	FROM cran_logs_2015_01_01
	GROUP BY package
	ORDER BY b DESC
	LIMIT 2
) temp
ORDER BY temp.b ASC
LIMIT 1;


-- 9.11 Print the name of the package whose download count is bigger than 1000.

-- Solution 1 (without sub-query)
SELECT package
FROM cran_logs_2015_01_01
GROUP BY package
HAVING count(*) > 1000;

-- Solution 2 (with sub-query)
SELECT temp.package
FROM
(
SELECT package, COUNT(*) as count
	FROM cran_logs_2015_01_01
	GROUP BY package
) AS temp
WHERE temp.count > 1000;
