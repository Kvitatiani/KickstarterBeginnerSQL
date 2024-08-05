# SQL Beginner Project

Welcome to my first SQL project! This repository contains a collection of SQL queries that demonstrate basic SQL operations and data manipulation. This is the easiest project I’m starting with, and I plan to add more complex projects in the future.

## Contents

This repository includes various SQL queries that cover a range of fundamental SQL tasks. Below is a summary of the queries included:

1. Basic Data Retrieval
   SELECT * FROM kickstarter_projects;
   
    SELECT TOP 10
    *
  FROM kickstarter_projects
  ORDER BY usd_pledged DESC;

3. Column Management

 Dropping unnecessary columns:

ALTER TABLE dbo.kickstarter_projects
DROP COLUMN [column15],[column16],[column17];

 Adding a custom column:

ALTER TABLE kickstarter_projects
ADD completion_pct FLOAT NULL;
Changing column data type:

ALTER TABLE kickstarter_projects
ALTER COLUMN completion_pct DECIMAL(10,2);
Renaming a column for clarity:

EXEC sp_rename 'kickstarter_projects.project_length', 'funding_window', 'COLUMN';
3. Handling Null Values

Checking for null values:

SELECT * FROM kickstarter_projects
WHERE category IS NULL;
Counting null values:

SELECT COUNT(*) AS NullCount
FROM kickstarter_projects
WHERE category IS NULL;
Deleting rows with null values:

DELETE FROM kickstarter_projects
WHERE category IS NULL;
4. Data Update and Calculation

Updating column values based on rules:

UPDATE kickstarter_projects
SET completion_pct = CASE
    WHEN goal IS NULL OR goal = 0 THEN NULL
    ELSE (pledged/goal)/100
END;
Calculating project length in months:

UPDATE kickstarter_projects
SET project_length = DATEDIFF(MONTH, launched, deadline);
5. Data Aggregation and Analysis

Counting and percentage of project states:

SELECT
    state,
    COUNT(*) AS StateCount,
    COUNT(*)*100.0/(SELECT COUNT(*) FROM kickstarter_projects) AS PercentageOfTotal
FROM kickstarter_projects
GROUP BY state;
Projects where pledge amount exceeds goal:

SELECT * FROM kickstarter_projects
WHERE completion_pct >= 100;

Most and least successful projects by category:

SELECT TOP 10
    category,
    COUNT(*) AS SuccessCount
FROM kickstarter_projects
WHERE state = 'successful'
GROUP BY category
ORDER BY SuccessCount DESC;

SELECT TOP 10
    main_category,
    COUNT(*) AS SuccessCount
FROM kickstarter_projects
WHERE state = 'successful'
GROUP BY main_category
ORDER BY SuccessCount;

SELECT TOP 10
    main_category,
    COUNT(*) AS SuccessCount
FROM kickstarter_projects
WHERE state = 'successful'
GROUP BY main_category
ORDER BY SuccessCount;

6. Date and Time Handling

Formatting date columns:

SELECT CONVERT(VARCHAR(10), deadline, 23) AS FormattedDate
FROM kickstarter_projects;

7. Data Cleanup

Removing irrelevant rows:

DELETE FROM kickstarter_projects
WHERE launched = '1970-01-01 01:00:00.0000000';


_This my first independent SQL attempt, I will be uploading projects based on their complexity in the future.

Free dataset used in the project was retrieved from Kaggle. _


