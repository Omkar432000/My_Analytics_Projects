create database Projects;
use projects;
select * from dataset1;
select * from dataset2;

-- number of rows in datasets
select count(*) from dataset1;
select count(*) from dataset2;

-- info for jharkhand and bihar
select distinct state from dataset1;
select * from dataset1 where state in ("Jharkhand","Bihar");
select count(*) from dataset1 where state = "Jharkhand";
select count(*) from dataset1 where state = "Bihar";

-- Total population of India
select * from dataset1;
select sum(Population) as population from dataset2;

-- Average growth
select avg(Growth) as avg_growth from dataset1;
select state , avg(growth) as avg_growth from dataset1 group by state;

-- Avg sex ratio
select round(avg(Sex_ratio),0) as avg_sex_ratio from dataset1;
select state,round(avg(sex_ratio),0) as avg_sex_ratio from dataset1 group by state order by avg_sex_ratio desc;

-- Avg literacy rate
select * from dataset1;
select round(avg(literacy),2) as avg_letracy_rate from dataset1;
select state, round(avg(literacy),2) as avg_letracy_rate from dataset1 group by state order by avg_letracy_rate desc;

select state , round(avg(literacy),2) as avg_literacy_rate from dataset1 group by state
having round(avg(literacy),2) > 85 order by avg_literacy_rate desc;

-- top 3 & bottom 3 state with heighst & lowest growth ratio
# Top 3
select state , avg(Growth) as top_three from dataset1 group by state order by top_three desc limit 3;
# Bottom 3
select state ,avg (Growth) as bottom_three from dataset1 group by state order by bottom_three asc limit 3;

-- top 3 & bottom 3 state with heighst & lowest sex ratio
# Top 3
select state ,round(avg(growth),2) as top_three from dataset1 group by state order by top_three desc limit 3;
# Bottom 3
select state ,round(avg(growth),2) as bottom_three from dataset1 group by state order by bottom_three asc limit 3;

-- top 3 & bottom 3 state with heighst & lowest sex ratio
# Top 3
select state , round(avg(literacy),2) as top_three from dataset1 group by state order by top_three desc limit 3; 
# Bottom 3
select state , round(avg(literacy),2) as bottom_three from dataset1 group by state order by bottom_three asc limit 3; 

-- Temp table
# top
CREATE TEMPORARY TABLE topstates
AS
SELECT state, ROUND(AVG(literacy), 0) AS topstate
FROM dataset1
GROUP BY state
ORDER BY topstate DESC;

SELECT * FROM topstates
ORDER BY topstate DESC
LIMIT 3;

-- state start with end with 
select distinct state from dataset1 where state like "A%"; 
select distinct state from dataset1 where state like "Ma%";
select distinct state from dataset1 where state like "M%" or state like "T%";
select distinct state from dataset1 where state like "%a";

-- Numbers of male and females

select * from dataset1;
select * from dataset2;
/*
UPDATE dataset1
SET column_name = REPLACE(column_name, 'ï»¿', '')
WHERE column_name LIKE '%ï»¿%';
*/
# joining table
SELECT 
    a.ï»¿District, a.state, a.sex_ratio, b.population
FROM
    dataset1 a
        INNER JOIN
    dataset2 b ON a.ï»¿District = b.ï»¿District;

-- finding male and female
/*
female/male = sex_ratio ------eq1
females+male = populations --------eq2
females = population-male -----------eq3
(population-male)= (sex_ratio)*male
population= male(sex_ratio +1)
male = population/(sex_ratio +1)
female= population-population/(sex_ratio+1)
=population(1-1/(sex_ratio+1))
=(population*(sex_ratio))/(sex_ratio+1)
*/
SELECT
    c.ï»¿District,
    c.state,
   round( c.population / (c.sex_ratio + 1),0) AS males,
    round(c.population * c.sex_ratio / (c.sex_ratio + 1),0) AS females
FROM
    (
        SELECT
            a.ï»¿District,
            a.state,
            a.sex_ratio/1000 sex_ratio,
            b.population
        FROM
            dataset1 a
        INNER JOIN
            dataset2 b ON a.ï»¿District = b.ï»¿District
    ) c;
    
    