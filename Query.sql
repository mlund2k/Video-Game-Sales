-- In MySQL, database creation is a bit more manual, firstly I will begin by setting up a schema, or table structure, for the data I intend to import

-- Create database from scratch, and set my environment to this database
CREATE DATABASE IF NOT EXISTS vgames;

USE vgames;

-- Create a schema for the table by specifying the column name and type
CREATE TABLE games
(
	img VARCHAR(255),
    title VARCHAR(255),
    console VARCHAR(255),
    genre VARCHAR(255),
    publisher VARCHAR(255),
    critic_score DOUBLE,
    total_sales DOUBLE,
    na_sales DOUBLE,
    jp_sales DOUBLE,
    pal_sales DOUBLE,
    other_sales DOUBLE,
    release_date DATE
);

-- Null values in the numerical columns are causing errors as they are interpreted as empty strings by the interpreter, and raise a completely unrelated error involving data truncation.
-- After being sent on a wild goose chase and trying to conceptualize why this error would come up in the interpreter, I managed to pinpoint the actual error and rectify a solution.
-- Thanks MySQL
-- I was able to convert the empty strings that got flagged to actual nulls using the built in NULLIF() function, but its a lot of code
LOAD DATA INFILE 'vgames.csv' INTO TABLE games
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@v1, @v2, @v3, @v4, @v5, @v6, @v7, @v8, @v9, @v10, @v11, @v12)
SET img = NULLIF(@v1,''),
title = NULLIF(@v2,''),
console = NULLIF(@v3,''),
genre = NULLIF(@v4,''),
publisher = NULLIF(@v5,''),
critic_score = NULLIF(@v6,''),
total_sales = NULLIF(@v7,''),
na_sales = NULLIF(@v8,''),
jp_sales = NULLIF(@v9,''),
pal_sales = NULLIF(@v10,''),
other_sales = NULLIF(@v11,''),
release_date = NULLIF(@v12,'');

-- NOW the table is finally imported and I can query it, this entire process is automated in most other SQL programs fortunately

-- First I want to create a table to save my query to that can be used in a visualization program.
CREATE TABLE IF NOT EXISTS games_analysis LIKE games
SELECT title,
	genre,
	publisher,
    ROUND(AVG(critic_score),1) AS avg_ratings,
    ROUND(SUM(na_sales),2) AS na_sales,
    ROUND(SUM(pal_sales),2) AS pal_sales,
    ROUND(SUM(jp_sales),2) AS jp_sales,
    ROUND(SUM(other_sales),2) AS other_sales,
	ROUND(SUM(total_sales),2) AS total_sales,
    MIN(release_date) AS release_date,
    LEFT(MIN(release_date), 4) AS release_year
FROM games
GROUP BY title, genre, publisher
HAVING total_sales IS NOT NULL AND total_sales > 0
ORDER BY total_sales DESC;

-- The resultant query aggregates sales and ratings by game title, genre, and publisher, and filters out games with less than 100K copies sold
