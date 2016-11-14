#More JOIN operations

#1. List the films where the yr is 1962 [Show id, title] 

SELECT id, title
FROM movie
WHERE yr=1962

#2 Give year of 'Citizen Kane'
SELECT yr 
FROM movie 
WHERE title = 'Citizen Kane';

#3 List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. 
SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
Order BY yr;

#4 What are the titles of the films with id 11768, 11955, 21191 
SELECT title
FROM movie
WHERE id IN (11768, 11955, 21191);

#5 What id number does the actress 'Glenn Close' have? 
SELECT id
FROM actor
WHERE name = 'Glenn Close';

#6 What is the id of the film 'Casablanca' 
SELECT id
FROM movie
WHERE title = 'Casablanca';

#7 Obtain the cast list for 'Casablanca'.
# Use movieid=11768, this is the value that you obtained in the previous question. 

SELECT name
FROM casting JOIN actor ON (id = actorid)
WHERE movieid = 11768;

#8 Obtain the cast list for the film 'Alien' 

SELECT name
FROM actor JOIN casting ON (id = actorid)
WHERE casting.movieid = 
(SELECT id FROM movie WHERE title = 'Alien');

#9 List the films in which 'Harrison Ford' has appeared 

SELECT title
FROM movie JOIN casting ON (id = movieid)
WHERE actorid = 
(SELECT id 
FROM actor
WHERE name = 'Harrison Ford');


#10 List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role] 

SELECT title
FROM movie JOIN casting ON (id = movieid)
WHERE actorid = 
(SELECT id 
FROM actor
WHERE name = 'Harrison Ford')
AND ord <> 1;

# 11 List the films together with the leading star for all 1962 films. 

SELECT title, name
FROM movie JOIN casting ON (movie.id = movieid)
JOIN actor ON (actor.id = actorid)
WHERE yr = 1962 AND ord = 1;

# 12 Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) FROM
movie JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
movie JOIN casting ON movie.id=movieid
JOIN actor   ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr) AS t
);

#13 List the film title and the leading actor for all of the films 'Julie Andrews' played in.
#Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
#Title is not a unique field, create a table of IDs in your subquery
#OMG this question drove me nuts!

SELECT title, name
FROM casting JOIN movie ON (movie.id = movieid)
JOIN actor ON (actor.id = actorid)


WHERE movieid IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor
WHERE name='Julie Andrews')) AND ord = 1;

#14 Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles. 

SELECT name
FROM actor JOIN casting ON (actor.id = actorid)
WHERE ord = 1
GROUP BY actorid, name
HAVING COUNT(actorid) >= 30

#15 List the films released in the year 1978 ordered by the number of actors in the cast, then by title. 

SELECT title, COUNT(movieid) AS 'Cast Members'
FROM casting JOIN movie ON (movie.id = movieid)
JOIN actor ON (actor.id = actorid)
WHERE yr = 1978
GROUP BY movieid, title
ORDER BY COUNT(movieid) DESC, title;

# 16 List all the people who have worked with 'Art Garfunkel'. 

SELECT name
FROM actor JOIN casting ON (actor.id = actorid)
WHERE movieid 
IN (SELECT movieid FROM casting WHERE actorid 
IN (SELECT id FROM actor WHERE name = 'Art Garfunkel')) 
AND name <> 'Art Garfunkel';
