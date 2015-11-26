-- Select the title of all movies.
select title from movies;
 
-- Show all the distinct ratings in the database.
select distinct rating from movies;
select * from movies;

 
-- Show all unrated movies.
select * 
from movies
where rating is NULL;

-- Select all movie theaters that are not currently showing a movie.
select * from MovieTheaters
where Movie is NULL;

-- Select all data from all movie theaters 
-- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).

-- This query below would fail as it will only return the theaters with movies shown.
-- we need to use left outer join instead
select * 
from MovieTheaters join Movies 
on MovieTheaters.movie = Movies.code;

-- correct query
SELECT *
   FROM MovieTheaters LEFT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code;



-- Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.

-- the query below would fail
select *
from movies right join movietheaters 
on movies.code = movietheaters.movie;

-- Correct solution
 SELECT *
   FROM MovieTheaters RIGHT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code;



-- Show the titles of movies not currently being shown in any theaters.
-- VERY IMPORTANT
-- the query below would fail due to the NULL value returned by the subquery
select title 
from movies
where code not in ( 
select movie from movietheaters
);

 /* With JOIN */
 SELECT Movies.Title
   FROM MovieTheaters RIGHT JOIN Movies
   ON MovieTheaters.Movie = Movies.Code
   WHERE MovieTheaters.Movie IS NULL;

 /* With subquery */
 SELECT Title FROM Movies
   WHERE Code NOT IN
   (
     SELECT Movie FROM MovieTheaters
     WHERE Movie IS NOT NULL
   );
 
-- Add the unrated movie "One, Two, Three".
insert into Movies(Title) values('One, Two, Three');

INSERT INTO Movies(Title,Rating) VALUES('One, Two, Three',NULL);

select * from Movies;
-- 
-- Set the rating of all unrated movies to "G".
update Movies
set Rating = 'G'
where Rating is NULL;

-- Remove movie theaters projecting movies rated "NC-17".
delete from MovieTheaters 
where Movie in (
select Code from Movies where Rating = 'NC-17'
);