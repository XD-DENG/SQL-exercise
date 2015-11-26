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



-- Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
-- 
-- 
-- 
-- Show the titles of movies not currently being shown in any theaters.
-- 
-- 
-- Add the unrated movie "One, Two, Three".
-- 
-- 
-- Set the rating of all unrated movies to "G".
-- 
-- 
-- Remove movie theaters projecting movies rated "NC-17".
-- 
-- 
-- 