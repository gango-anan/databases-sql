--QUIZ 1
SELECT name, population FROM world
  WHERE population BETWEEN 1000000 AND 1250000;

SELECT name, population FROM world
  WHERE name LIKE "Al%";

SELECT name FROM world
  WHERE name LIKE '%a' OR name LIKE '%l';

SELECT name,length(name) FROM world
  WHERE length(name)=5 and region='Europe';

SELECT name, area*2 FROM world WHERE population = 64000;

SELECT name, area, population FROM world
  WHERE area > 50000 AND population < 10000000;

SELECT name, population/area FROM world
  WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

--QUIZ 2
SELECT name FROM world
  WHERE name LIKE 'U%';

SELECT population FROM world
  WHERE name = 'United Kingdom';

SELECT continent FROM world 
  WHERE 'name' = 'France';

SELECT name, population FROM world
  WHERE continent IN ('Europe', 'Asia');

SELECT name FROM world
  WHERE name IN ('Cuba', 'Togo');

SELECT name FROM world
  WHERE continent = 'South America'
    AND population > 40000000;

--QUIZ 3
SELECT winner FROM nobel
  WHERE winner LIKE 'C%' AND winner LIKE '%n';

SELECT COUNT(subject) FROM nobel
  WHERE subject = 'Chemistry' AND yr BETWEEN 1950 and 1960;

SELECT COUNT(DISTINCT yr) FROM nobel
  WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine');

SELECT subject, winner FROM nobel WHERE winner LIKE 'Sir%' AND yr LIKE '196%';

SELECT yr FROM nobel
  WHERE yr NOT IN(SELECT yr FROM nobel WHERE subject IN ('Chemistry','Physics'));

SELECT DISTINCT yr FROM nobel
  WHERE subject='Medicine' AND yr NOT IN(SELECT yr FROM nobel WHERE subject='Literature')
    AND yr NOT IN (SELECT yr FROM nobel WHERE subject='Peace');

SELECT subject, COUNT(subject) FROM nobel 
  WHERE yr ='1960' GROUP BY subject;

--QUIZ 4
SELECT region, name, population FROM bbc x
  WHERE population <= ALL (SELECT population FROM bbc y WHERE y.region=x.region AND population>0);

SELECT name,region,population FROM bbc x
  WHERE 50000 < ALL (SELECT population FROM bbc y WHERE x.region=y.region AND y.population>0);

SELECT name, region FROM bbc x
  WHERE population < ALL (SELECT population/3 FROM bbc y WHERE y.region = x.region AND y.name != x.name);

SELECT name FROM bbc
  WHERE population > (SELECT population FROM bbc WHERE name='United Kingdom')
    AND region IN (SELECT region FROM bbc WHERE name = 'United Kingdom');

SELECT name FROM bbc
 WHERE gdp > (SELECT MAX(gdp) FROM bbc WHERE region = 'Africa');

SELECT name FROM bbc
  WHERE population < (SELECT population FROM bbc WHERE name='Russia')
    AND population > (SELECT population FROM bbc WHERE name='Denmark');

SELECT name FROM bbc
  WHERE population > ALL (SELECT MAX(population) FROM bbc WHERE region = 'Europe')
    AND region = 'South Asia';

--QUIZ 5
SELECT SUM(population) FROM bbc WHERE region = 'Europe';

SELECT COUNT(name) FROM bbc WHERE population < 150000;

-- AVG(), COUNT(), MAX(), MIN(), SUM()

-- No result due to invalid use of the WHERE function

SELECT AVG(population) FROM bbc WHERE name IN ('Poland', 'Germany', 'Denmark');

SELECT region, SUM(population)/SUM(area) AS density FROM bbc GROUP BY region;

SELECT name, population/area AS density FROM bbc WHERE population = (SELECT MAX(population) FROM bbc);

SELECT region, SUM(area) FROM bbc 
  GROUP BY region HAVING SUM(area)<= 20000000;

--QUIZ 6
game  JOIN goal ON (id=matchid);

matchid, teamid, player, gtime, id, teamname, coach;

SELECT player, teamid, COUNT(*) FROM game JOIN goal ON matchid = id
  WHERE (team1 = "GRE" OR team2 = "GRE") AND teamid != 'GRE' GROUP BY player, teamid;

SELECT DISTINCT teamid, mdate FROM goal JOIN game on (matchid=id)
  WHERE mdate = '9 June 2012';

SELECT DISTINCT player, teamid FROM game JOIN goal ON matchid = id
  WHERE stadium = 'National Stadium, Warsaw' AND (team1 = 'POL' OR team2 = 'POL') AND teamid != 'POL';

SELECT DISTINCT player, teamid, gtime FROM game JOIN goal ON matchid = id
  WHERE stadium = 'Stadion Miejski (Wroclaw)' AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'));

SELECT teamname, COUNT(*) FROM eteam
  JOIN goal ON teamid = id GROUP BY teamname HAVING COUNT(*) < 3;

--QUIZ 7
SELECT name FROM actor INNER JOIN movie ON actor.id = director
  WHERE gross < budget;

SELECT * FROM actor JOIN casting ON actor.id = actorid
  JOIN movie ON movie.id = movieid;

SELECT name, COUNT(movieid) FROM casting JOIN actor ON actorid=actor.id
  WHERE name LIKE 'John %' GROUP BY name ORDER BY 2 DESC;

SELECT title FROM movie JOIN casting ON (movieid=movie.id)
  JOIN actor   ON (actorid=actor.id) WHERE name='Paul Hogan' AND ord = 1;

SELECT name FROM movie JOIN casting ON movie.id = movieid
  JOIN actor ON actor.id = actorid WHERE ord = 1 AND director = 351;

/*
link the director column in movies with the primary key in actor
connect the primary keys of movie and actor via the casting table
*/

SELECT title, yr FROM movie, casting, actor
  WHERE name='Robert De Niro' AND movieid=movie.id AND actorid=actor.id AND ord = 3;

--QUIZ 8
SELECT teacher.name, dept.name FROM teacher LEFT OUTER JOIN dept ON (teacher.dept = dept.id);

SELECT dept.name FROM teacher JOIN dept ON (dept.id = teacher.dept) WHERE teacher.name = 'Cutflower';

SELECT dept.name, COUNT(teacher.name) FROM teacher RIGHT JOIN dept ON dept.id = teacher.dept GROUP BY dept.name;

SELECT name, dept, COALESCE(dept, 0) AS result FROM teacher on teacher;

SELECT name,
       CASE WHEN phone = 2752 THEN 'two'
            WHEN phone = 2753 THEN 'three'
            WHEN phone = 2754 THEN 'four'
            END AS digit
  FROM teacher;

SELECT name, 
      CASE 
       WHEN dept 
        IN (1) 
        THEN 'Computing' 
       ELSE 'Other' 
      END 
  FROM teacher;

--QUIZ 9
SELECT DISTINCT a.name, b.name
  FROM stops a JOIN route z ON a.id=z.stop
  JOIN route y ON y.num = z.num
  JOIN stops b ON y.stop=b.id
 WHERE a.name='Craiglockhart' AND b.name ='Haymarket';

SELECT S2.id, S2.name, R2.company, R2.num
  FROM stops S1, stops S2, route R1, route R2
 WHERE S1.name='Haymarket' AND S1.id=R1.stop
   AND R1.company=R2.company AND R1.num=R2.num
   AND R2.stop=S2.id AND R2.num='2A';

SELECT a.company, a.num, stopa.name, stopb.name
  FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
 WHERE stopa.name='Tollcross';