CREATE DATABASE portfolio_project;
USE portfolio_project;
SHOW TABLES;
DESC hr;
SELECT *
FROM hr;
ALTER TABLE hr CHANGE COLUMN ï»¿id emp_id VARCHAR(20);
ALTER TABLE hr MODIFY emp_id VARCHAR(20) NULL;
SELECT birthdate,age FROM hr;

-- CHANGING THE BIRTHDATE,TERMDATE AND HIRE DATE DATE TYPE
ALTER TABLE hr MODIFY birthdate DATE;
ALTER TABLE hr MODIFY hire_date DATE;
ALTER TABLE hr MODIFY COLUMN termdate date;
SHOW WARNINGS;
SET GLOBAL sql_mode = '';

-- TURNING OFF MYSQL SAFE UPDATE OFF
SET sql_safe_updates = 0;

-- FORMATTING THE BIRTHDATE
UPDATE hr SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
    ELSE NULL
END;

-- ADDING AN AGE COLUMN TO THE HR TABLE
ALTER TABLE hr ADD age INT;

-- CALCULATING THE AGE
UPDATE hr SET age = TIMESTAMPDIFF(YEAR,birthdate,CURDATE());

-- FORMATTING THE HIREDATE
UPDATE hr SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
	WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
	ELSE NULL
END;


SELECT termdate FROM hr;

-- CHANGING THE FORMATE OF THE TERMDATE
UPDATE hr SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

-- UPDATE hr SET termdate = DATE(str_to_date(termdate,'%Y-%m-%d'))
-- WHERE termdate IS NULL;

UPDATE hr
SET termdate = COALESCE(termdate, '0000-00-00')
WHERE termdate IS NULL OR termdate = '';

SELECT MIN(AGE),MAX(AGE) FROM hr;
SELECT COUNT(*) FROM hr 
WHERE age < 18;

