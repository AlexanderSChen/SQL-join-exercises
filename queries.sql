-- write your queries here
SELECT * FROM owners LEFT JOIN vehicles ON owners.id = vehicles.owner_id;

SELECT first_name, last_name, COUNT(owner_id) AS count FROM owners o JOIN vehicles v ON o.id = v.owner_id GROUP BY (first_name, last_name) ORDER BY o.first_name ASC;

-- SELECT first_name, last_name, AVG(SUM(price)) AS average_price, COUNT(owner_id) AS count FROM owners o JOIN vehicles v ON o.id = v.owner_id WHERE count > 1 AND average_price > 10000 GROUP BY (first_name, last_name) ORDER BY
--  first_name DESC;

 SELECT first_name, last_name, ROUND(AVG(price)) AS average_price, COUNT(owner_id) FROM owners o JOIN ve
hicles v ON o.id = v.owner_id GROUP BY (first_name, last_name) HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000
ORDER BY first_name DESC;

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game WHERE id = '1012'

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid = 'ger'

SELECT team1, team2, player FROM game JOIN goal ON id = matchid WHERE player LIKE 'Mario%'

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid = id
 WHERE gtime<=10

SELECT mdate, teamname FROM game JOIN eteam ON team1 = eteam.id WHERE coach = 'Fernando Santos'

SELECT player FROM game JOIN goal ON id = matchid WHERE stadium = 'National Stadium, Warsaw' 

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND goal.teamid != 'GER'


SELECT teamname, COUNT(player)
  FROM eteam JOIN goal ON id=teamid
 GROUP BY teamname

SELECT stadium, COUNT(player) FROM game JOIN goal ON id = matchid
GROUP BY stadium

SELECT matchid,mdate, COUNT(teamid)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

SELECT matchid, mdate, COUNT(teamid) FROM game JOIN goal ON id = matchid WHERE teamid = 'GER' GROUP BY matchid, mdate

SELECT mdate,
  team1, 
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id GROUP BY mdate, matchid, team1, team2

SELECT id, title
 FROM movie
 WHERE yr=1962

SELECT yr FROM movie WHERE title = 'Citizen Kane'

SELECT id, title, yr FROM movie WHERE title LIKE 'Star Trek%'

SELECT id FROM actor WHERE name = 'Glenn Close'

SELECT id FROM movie WHERE title = 'Casablanca'

SELECT name FROM actor JOIN casting ON id = actorid WHERE movieid = 27

SELECT name FROM actor JOIN casting ON id = actorid WHERE movieid = 35

SELECT title FROM movie JOIN casting ON id = movieid WHERE actorid = 6

SELECT DISTINCT movie.title FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE actor.name = 'Harrison Ford' AND casting.ord != 1

SELECT DISTINCT title, name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid WHERE movie.yr = 1962 AND casting.ord = 1

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 1

SELECT title, name FROM movie m JOIN casting c ON m.id = movieid AND ord = 1 JOIN actor a ON a.id = c.actorid WHERE m.id IN (SELECT movieid FROM casting WHERE actorid IN (SELECT id FROM actor WHERE name = 'Julie Andrews'))

SELECT name FROM actor JOIN casting ON actor.id = actorid WHERE casting.ord = 1 GROUP BY name  HAVING COUNT(*) >= 15

SELECT title, COUNT(actorid) FROM movie JOIN casting ON movie.id = movieid WHERE yr = 1978
  GROUP BY title ORDER BY COUNT(actorid) DESC, title

SELECT name FROM actor JOIN casting ON actor.id = actorid
WHERE movieid IN
  (SELECT id FROM movie WHERE title IN
    (SELECT title FROM movie JOIN casting ON movie.id = movieid WHERE actorid IN
      (SELECT id FROM actor WHERE name = 'Art Garfunkel')))
  AND name != 'Art Garfunkel'