-- ==================================================================================================================
-- Netflix Data Cleaning Script
-- ==================================================================================================================
-- Project: Netflix SQL Data Analysis
-- Description: This script cleans and standardizes the raw Netflix dataset
-- by trimming text fields, handling NULL values and correcting misplaced rating values, and converting date formats.
-- A cleaned view (vw_netflix_clean) is created for further analysis.
-- ==================================================================================================================

-- Create a cleaned view for analysis
CREATE VIEW vw_netflix_clean AS

---

-- Step 1: Data Cleaning using CTE

---

WITH Base_query AS (
SELECT

    -- Remove extra spaces from key identifiers
    TRIM(show_id) AS show_id,

    -- Standardize text columns
    TRIM(type) AS type,
    TRIM(title) AS title,

    -- Replace NULL values with 'Unknown'
    ISNULL(TRIM(director), 'Unknown') AS director,
    ISNULL(TRIM(cast), 'Unknown') AS cast,
    ISNULL(TRIM(country), 'Unknown') AS country,

    -- Convert date_added from text to DATE format
    CAST(TRIM(date_added) AS DATE) AS date_added,

    -- Release year already stored as integer
    release_year,

    -- Fix incorrect rating values where duration
    -- was mistakenly stored in the rating column
    CASE
        WHEN rating LIKE '%min%' THEN NULL
        ELSE TRIM(rating)
    END AS rating,

    -- Clean remaining text columns
    TRIM(duration) AS duration,
    TRIM(listed_in) AS listed_in,
    TRIM(description) AS description

FROM netflix
)

-------------------------------------------------

-- Step 2: Final Clean Dataset
-- Remove rows with critical NULL values

-------------------------------------------------

SELECT
show_id,
type,
title,
director,
cast,
country,
release_year,
date_added,
rating,
duration,
listed_in,
description

FROM Base_query

-- Filter out incomplete records for reliable analysis
WHERE date_added IS NOT NULL
AND rating IS NOT NULL
AND duration IS NOT NULL;
