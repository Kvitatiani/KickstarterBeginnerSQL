SELECT * FROM
kickstarter_projects;

-- dropped unneccesary columns
ALTER TABLE dbo.kickstarter_projects
DROP COLUMN [column15],[column16],[column17];

-- check for null values in specific column
SELECT * FROM kickstarter_projects
WHERE category IS NULL;

-- count null values in specific column
SELECT COUNT(*) AS NullCount
FROM kickstarter_projects
WHERE category IS NULL;

-- delete rows based on column containing null values
DELETE FROM kickstarter_projects
WHERE category IS NULL;

-- add custom column
ALTER TABLE kickstarter_projects
ADD completion_pct FLOAT NULL;

-- change column data type
ALTER TABLE kickstarter_projects
ALTER COLUMN completion_pct DECIMAL(10,2);

-- change column values based on rule
UPDATE kickstarter_projects
SET completion_pct = pledged/goal;

UPDATE kickstarter_projects
SET completion_pct = CASE
						WHEN goal IS NULL OR goal = 0 THEN NULL
						ELSE (pledged/goal)/100
				     END;

SELECT * FROM kickstarter_projects
WHERE pledged IS NULL;

-- deleting NULL values once more from column 'goal', this also fixed corrupted data entry
DELETE FROM kickstarter_projects
WHERE goal IS NULL;

-- value counts and % of total project states
SELECT
	state,
	COUNT(*) AS StateCount,
	COUNT(*)*100.0/(SELECT COUNT(*) FROM kickstarter_projects) AS PercentageOfTotal
FROM kickstarter_projects
GROUP BY state;

-- select projects where pledge amount exceeds goal
SELECT * FROM
kickstarter_projects
WHERE completion_pct >= 100;

-- convert column deadline's datetype to yyyy-mm-dd format
SELECT CONVERT(VARCHAR(10), deadline, 23) AS FormattedDate
FROM kickstarter_projects;

-- create a new column
ALTER TABLE kickstarter_projects
ADD project_length DECIMAL(10,1) NULL;

-- alter column and set to integer
ALTER TABLE kickstarter_projects
ALTER COLUMN project_length INT;

-- set new column as difference in months between launch and deadline date, NOTE: this is not the actual project length of course
UPDATE kickstarter_projects
SET project_length = DATEDIFF(MONTH, launched, deadline);


-- let's change name of the column so it doesn't confuse the reader
EXEC sp_rename 'kickstarter_projects.project_length', 'funding_window', 'COLUMN';


SELECT *
FROM kickstarter_projects
ORDER BY funding_window DESC;

-- we can see that there are some projects with launched date as 1970-01-01, all of them are canceled or suspended,
-- we want to drop those, as they are irrelevant
DELETE
FROM kickstarter_projects
WHERE launched = '1970-01-01 01:00:00.0000000'



