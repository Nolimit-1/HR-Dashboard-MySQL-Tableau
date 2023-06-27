-- QUESTIONS
-- 1. What is the gender breakdown of employees in the company? There are 654 males,565 females and 37 non.conforming
-- SOLUTION
SELECT gender,COUNT(gender) AS count FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY gender;
SHOW WARNINGS;

SELECT DISTINCT(gender) FROM hr;

-- 2. What is the race/ethnicity breakdown of employees in the company?
SELECT race,COUNT(*) AS count FROM hr 
WHERE age >= 18 AND termdate = ''
GROUP BY race
ORDER BY count DESC;
-- 3. What is the age distribution of employees in the company?
SELECT MIN(age) AS youngest,MAX(age) AS oldest FROM hr
WHERE age >= 18 AND termdate = '';

SELECT CASE
	WHEN age >=18 AND age <= 24 THEN '18-24'
    WHEN age >=25 AND age <= 34 THEN '25-34'
    WHEN age >=35 AND age <= 44 THEN '35-44'
    WHEN age >=45 AND age <= 54 THEN '45-54'
    WHEN age >=55 AND age <= 64 THEN '55-64'
    ELSE '65+'
	END AS age_group,
    COUNT(*) AS count FROM hr
    WHERE age >= 18 AND termdate = ''
	GROUP BY age_group
	ORDER BY age_group;
    
    SELECT CASE
	WHEN age >=18 AND age <= 24 THEN '18-24'
    WHEN age >=25 AND age <= 34 THEN '25-34'
    WHEN age >=35 AND age <= 44 THEN '35-44'
    WHEN age >=45 AND age <= 54 THEN '45-54'
    WHEN age >=55 AND age <= 64 THEN '55-64'
    ELSE '65+'
	END AS age_group,gender,
    COUNT(*) AS count FROM hr
    WHERE age >= 18 AND termdate = ''
	GROUP BY age_group,gender
	ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?
SELECT location, COUNT(*) AS count FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY location;

-- 5. What is the average length of employment for employees who have been terminated?
SELECT ROUND(AVG(DATEDIFF(termdate,hire_date))/365,0) AS avg_length_employment FROM hr
WHERE termdate <= CURDATE() AND termdate != '' AND age >= 18;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department,gender,COUNT(*) AS count FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY gender,department
ORDER BY department;

-- 7. What is the distribution of job titles across the company?
SELECT jobtitle, COUNT(*) AS count FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY jobtitle
ORDER BY jobtitle DESC;
-- 8. Which department has the highest turnover rate?
SELECT department,total_count,terminated_count,terminated_count/total_count AS termination_rate
FROM(
SELECT department,COUNT(*) AS total_count,
SUM(CASE WHEN termdate != '' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
FROM hr
WHERE age >= 18 
GROUP BY department ) AS sub_query
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by state?
SELECT location_state, COUNT(*) AS count FROM hr
WHERE age >= 18 AND termdate = ''
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates
SELECT year,
hires,
terminations,
hires-terminations AS net_change,
round(((hires-terminations)/hires) *100,2) AS net_percentage_change
FROM(
SELECT YEAR(hire_date) AS year, COUNT(*) AS hires,
SUM(CASE WHEN termdate != '' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations
FROM hr
WHERE age >= 18
GROUP BY year
)AS sub_query
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department,round(AVG(DATEDIFF(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE age >= 18 AND termdate <= CURDATE() AND termdate != ''
GROUP BY department
ORDER BY department;