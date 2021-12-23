-- ***************
-- Part 1
-- ***************

-- 1.
SELECT * FROM owners FULL JOIN vehicles ON owners.id = vehicles.owner_id;

-- 2
SELECT first_name, last_name, COUNT(owner_id) 
FROM owners 
JOIN vehicles 
ON owners.id = vehicles.owner_id 
GROUP BY owners.id
ORDER BY COUNT(owner_id) ASC ;

-- 3
SELECT first_name, last_name, ROUND(AVG(price)) AS average_price,COUNT(owner_id) 
FROM owners 
JOIN vehicles 
ON owners.id = vehicles.owner_id 
GROUP BY owners.first_name, owners.last_name 
HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000 
ORDER BY first_name DESC;

-- *******************
-- Part 2
-- *******************

-- 
-- 6 JOIN
-- 
-- 1.
SELECT matchid,player FROM goal 
WHERE teamid ='GER';
-- 2.
SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012;
-- 3.
SELECT player, teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';
-- 4.
SELECT team1,team2, player
FROM game 
JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';
-- 5.
SELECT player, teamid,coach,gtime
FROM goal 
JOIN eteam ON goal.teamid = eteam.id
WHERE gtime <=10;
-- 6.
SELECT mdate,teamname
FROM eteam
JOIN game ON eteam.id = game.team1
WHERE coach = 'Fernando Santos';
-- 7.
SELECT player
FROM goal
JOIN game ON goal.matchid = game.id
WHERE stadium = 'National Stadium, Warsaw';
-- 8.
SELECT player
FROM goal
JOIN game ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER') AND (teamid != 'GER')
GROUP BY player;
-- 9
SELECT teamname, COUNT(*) as total_goals
FROM goal 
JOIN eteam ON goal.teamid = eteam.id
GROUP BY teamname;
-- 10.
SELECT stadium, COUNT(*)
FROM goal
JOIN game ON goal.matchid = game.id
GROUP BY stadium
ORDER BY stadium;
-- 11.
SELECT id, mdate, COUNT(gtime)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE (team1 = 'POL' OR team2='POL')
GROUP BY id,mdate
-- 12.
SELECT id, mdate, COUNT(gtime)
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER'
GROUP BY id,mdate
-- 13.
SELECT game.mdate, game.team1, 
SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
team2,
SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2

FROM game LEFT JOIN goal ON matchid = id
GROUP BY game.id, mdate,team1,team2
ORDER BY mdate, matchid, team1, team2
-- 
-- 7.More JOIN operations
-- 
-- 1.
SELECT id, title FROM movie WHERE yr = 1962;
-- 2.
SELECT movie.yr 
FROM movie 
JOIN casting on movie.id = casting.movieid 
JOIN actor ON casting.actorid = actor.id
WHERE movie.title = 'Citizen Kane'
GROUP BY movie.yr
-- 3.
SELECT movie.id, movie.title, movie.yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;
-- 4.
SELECT id 
FROM actor
WHERE name = 'Glenn Close' ;

-- 5.
SELECT id FROM movie WHERE title = 'Casablanca';
-- 6.
SELECT actor.name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid = 11768
-- 7.
SELECT actor.name
FROM casting
JOIN movie ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE movie.title = 'Alien'
-- 8.
SELECT movie.title
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE actor.name = 'Harrison Ford';
-- 9.
SELECT movie.title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford' AND casting.ord >1;
-- 10.
SELECT movie.title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962 and casting.ord = 1;
-- 11.
SELECT yr, COUNT(title)
FROM movie 
JOIN casting on movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2
-- 12.
SELECT movie.title, actor.name
FROM casting
JOIN movie ON casting.movieid = movie.id AND casting.ord = 1
JOIN actor ON casting.actorid = actor.id

WHERE movie.id  IN (
    SELECT movieid FROM casting
    WHERE actorid IN (
        SELECT id FROM actor
        WHERE name = 'Julie Andrews')) 
-- 13.
SELECT actor.name
FROM actor 
JOIN casting ON (actor.id = casting.actorid AND casting.ord = 1)
GROUP BY actor.name HAVING COUNT(*) >=15
ORDER BY name;
-- 14.
SELECT title,COUNT(name)
FROM movie
JOIN casting ON casting.movieid = movie.id AND movie.yr = 1978
JOIN actor ON casting.actorid = actor.id
GROUP BY title
ORDER BY COUNT(name) desc, title;
-- OR
SELECT title,COUNT(name)
FROM movie
JOIN casting ON casting.movieid = movie.id
JOIN actor ON casting.actorid = actor.id
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(name) desc, title;
-- 15.
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid

WHERE movieid IN (
    SELECT movieid FROM casting
    WHERE actorid = (
        SELECT id FROM actor
        WHERE name = 'Art Garfunkel')) AND name != 'Art Garfunkel'
      


   



