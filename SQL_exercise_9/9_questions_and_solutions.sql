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

