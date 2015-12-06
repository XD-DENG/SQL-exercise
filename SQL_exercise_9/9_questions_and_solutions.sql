-- 9.1 give the total number of recordings in this table
select count(*) from cran_logs_2015_01_01;

-- 9.2 the number of packages listed in this table?
select count(distinct package) from cran_logs_2015_01_01;

-- 9.3 How many times the package "Rcpp" was downloaded?
select count(*) from cran_logs_2015_01_01 where package = "Rcpp";

-- 9.4 How many recordings are from China ("CN")?
select count(*) from cran_logs_2015_01_01 where country = "CN";

-- 9.5 Give the package name and how many times they're downloaded. Order descently.
select package, count(*) from cran_logs_2015_01_01 group by package order by 2 desc;