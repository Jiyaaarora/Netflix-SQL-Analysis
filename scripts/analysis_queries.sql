/*
========================================
Netflix Data Analysis using SQL
========================================
Author: Jiya Arora
Basic Exploratory Data Analysis (EDA) on cleaned Netflix dataset
========================================
*/

-- 1. Total Records
SELECT
    COUNT(*) AS total_records
FROM vw_netflix_clean;


-- 2. Movies vs TV Shows Count
SELECT
    type,
    COUNT(*) AS total_count
FROM vw_netflix_clean
GROUP BY type;


-- 3. Movies vs TV Shows Percentage
SELECT
    type,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_netflix_clean), 2) AS percentage
FROM vw_netflix_clean
GROUP BY type;


-- 4. Top 5 Countries by Content
SELECT TOP 5
    country,
    COUNT(*) AS total_content
FROM vw_netflix_clean
GROUP BY country
ORDER BY total_content DESC;


-- 5. Content Added Per Year (Recent First)
SELECT
    release_year,
    COUNT(*) AS total_content
FROM vw_netflix_clean
GROUP BY release_year
ORDER BY release_year DESC;


-- 6. Most Common Ratings
SELECT
    rating,
    COUNT(*) AS total_count
FROM vw_netflix_clean
GROUP BY rating
ORDER BY total_count DESC;


-- 7. Top 5 Genres
SELECT TOP 5
    listed_in AS genre,
    COUNT(*) AS total_count
FROM vw_netflix_clean
GROUP BY listed_in
ORDER BY total_count DESC;
