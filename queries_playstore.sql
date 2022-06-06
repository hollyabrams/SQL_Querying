-- Comments in SQL Start with dash-dash --

--hollyabrams@Hollys-iMac sql-querying % psql < seed_playstore.sql
--DROP DATABASE
--CREATE DATABASE
--You are now connected to database "playstore" as user "hollyabrams".
--CREATE TABLE
--INSERT 0 9637

--TABLE NAME analytics

--1. Find the app with an ID of 1880.
playstore=# SELECT * FROM analytics WHERE id = 1880;
  id  |        app_name         |   category   | rating | reviews |        size        | min_installs | price | content_rating |     genres     | last_updated | current_version |  android_version   
------+-------------------------+--------------+--------+---------+--------------------+--------------+-------+----------------+----------------+--------------+-----------------+--------------------
 1880 | Web Browser for Android | PRODUCTIVITY |    4.3 |  144879 | Varies with device |     10000000 |     0 | Everyone       | {Productivity} | 2016-01-24   | 3.5.0           | Varies with device
(1 row)

--2. Find the ID and app name for all apps that were last updated on August 01, 2018.
playstore=# SELECT id, app_name FROM analytics
playstore-# WHERE last_updated = '2018-08-01';

--3. Count the number of apps in each category, e.g. “Family | 1972”.
playstore=# SELECT category, COUNT(*) FROM analytics GROUP BY category;

--4. Find the top 5 most-reviewed apps and the number of reviews for each.
playstore=# SELECT * FROM analytics ORDER BY reviews DESC LIMIT 5;

--5. Find the app that has the most reviews with a rating greater than equal to 4.8.
playstore=# SELECT * FROM analytics WHERE rating >= 4.8 ORDER BY reviews DESC LIMIT 1;
-[ RECORD 1 ]---+---------------------
id              | 260
app_name        | Chess Free
category        | HEALTH_AND_FITNESS
rating          | 4.8
reviews         | 4559407
size            | Varies with device
min_installs    | 100000000
price           | 0
content_rating  | Everyone
genres          | {"Health & Fitness"}
last_updated    | 2018-08-01
current_version | Varies with device
android_version | Varies with device

--6. Find the average rating for each category ordered by the highest rated to lowest rated.
playstore=# SELECT category, AVG(rating) FROM analytics GROUP BY category ORDER BY avg DESC;


--7. Find the name, price, and rating of the most expensive app with a rating that’s less than 3.
playstore=# SELECT app_name, price, rating FROM analytics WHERE rating < 3 ORDER BY price DESC LIMIT 1;
      app_name      | price  | rating 
--------------------+--------+--------
 Naruto & Boruto FR | 379.99 |    2.9
(1 row)

--8. Find all apps with a min install not exceeding 50, that have a rating. Order your results by highest rated first.
SELECT * FROM analytics WHERE min_installs <= 50 AND rating IS NOT NULL ORDER BY rating DESC;

--9. Find the names of all apps that are rated less than 3 with at least 10000 reviews.
playstore=# SELECT app_name FROM analytics WHERE rating < 3 AND reviews >= 10000;
                    app_name                     
-------------------------------------------------
 The Wall Street Journal: Business & Market News
 Vikings: an Archer’s Journey
 Shoot Em Down Free
(3 rows)

--10. Find the top 10 most-reviewed apps that cost between 10 cents and a dollar.
playstore=# SELECT * FROM analytics WHERE price BETWEEN 0.1 and 1 ORDER BY reviews DESC LIMIT 10;

--11. Find the most out of date app. Hint: You don’t need to do it this way, but it’s possible to do with a subquery: http://www.postgresqltutorial.com/postgresql-max-function/
playstore=# SELECT * FROM analytics ORDER BY last_updated LIMIT 1;
-[ RECORD 1 ]---+----------------
id              | 5701
app_name        | CP Clicker
category        | FAMILY
rating          | 4.2
reviews         | 1415
size            | 209k
min_installs    | 100000
price           | 0
content_rating  | Everyone
genres          | {Entertainment}
last_updated    | 2010-05-21
current_version | 3.1
android_version | 1.5 and up

--12. Find the most expensive app (the query is very similar to #11).
playstore=# SELECT * FROM analytics ORDER BY price DESC LIMIT 1;
-[ RECORD 1 ]---+-------------------
id              | 6766
app_name        | Cardi B Piano Game
category        | LIFESTYLE
rating          | 3.6
reviews         | 275
size            | 7.3M
min_installs    | 10000
price           | 400
content_rating  | Everyone
genres          | {Lifestyle}
last_updated    | 2018-05-03
current_version | 1.0.1
android_version | 4.1 and up

--13. Count all the reviews in the Google Play Store.
playstore=# SELECT SUM(reviews) AS "All the Reviews" FROM analytics;
 All the Reviews 
-----------------
      4814575866
(1 row)

--14. Find all the categories that have more than 300 apps in them.
playstore=# SELECT category FROM analytics GROUP BY category HAVING COUNT(*) > 300;
    category     
-----------------
 COMMUNICATION
 PHOTOGRAPHY
 GAME
 BUSINESS
 MEDICAL
 TOOLS
 LIFESTYLE
 PRODUCTIVITY
 PERSONALIZATION
 FINANCE
 SPORTS
 FAMILY
(12 rows)

--15. Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion.
playstore=# SELECT app_name, reviews, min_installs, min_installs/reviews AS proportion
playstore-# FROM analytics
playstore-# WHERE min_installs >= 100000
playstore-# ORDER BY proportion DESC
playstore-# LIMIT 1;
     app_name     | reviews | min_installs | proportion 
------------------+---------+--------------+------------
 Kim Bu Youtuber? |      66 |     10000000 |     151515
(1 row)
