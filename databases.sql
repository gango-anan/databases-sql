--QUIZ 1
SELECT name, population
  FROM world
  WHERE population BETWEEN 1000000 AND 1250000;

SELECT name, population
  FROM world
  WHERE name LIKE "Al%";

SELECT name FROM world
  WHERE name LIKE '%a' OR name LIKE '%l';

SELECT name,length(name)
  FROM world
  WHERE length(name)=5 and region='Europe';

SELECT name, area*2 FROM world WHERE population = 64000;

SELECT name, area, population
  FROM world
  WHERE area > 50000 AND population < 10000000;

SELECT name, population/area
  FROM world
  WHERE name IN ('China', 'Nigeria', 'France', 'Australia');

--QUIZ 2
SELECT name
  FROM world
  WHERE name LIKE 'U%';

SELECT population
  FROM world
  WHERE name = 'United Kingdom';

SELECT continent 
  FROM world 
  WHERE 'name' = 'France';

SELECT name, population
  FROM world
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