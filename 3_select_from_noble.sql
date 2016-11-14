# We continue practicing simple SQL queries on a single table.
# This tutorial is concerned with a table of Nobel prize winners

# nobel(yr, subject, winner)

#1

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

#2

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature';

#3

SELECT yr, subject FROM nobel WHERE winner LIKE '%Einstein';

#4

SELECT winner FROM nobel WHERE yr >= 2000 AND subject = 'Peace';

#5

SELECT * FROM nobel WHERE yr BETWEEN 1980 AND 1989 AND subject = 'Literature';

#6

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter');

#7

SELECT winner FROM nobel WHERE winner LIKE 'John %';

#8

SELECT * FROM nobel WHERE (subject = 'Chemistry' AND yr = 1984) OR (subject = 'Physics' AND yr = 1980);

#9

SELECT * FROM nobel WHERE yr = 1980 AND subject NOT IN ('Medicine', 'Chemistry');

#10

SELECT * FROM nobel WHERE (subject = 'Medicine' AND yr < 1910) OR (subject = 'Literature' AND yr >= 2004);

#11

Select * FROM nobel WHERE winner = 'PETER GRÜNBERG';

#12

SELECT * FROM nobel WHERE winner = 'EUGENE O\'NEILL';

#13

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir %' ORDER BY yr DESC;
