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
  GROUP BY region
  HAVING SUM(area)<= 20000000