 CREATE DATABASE Life_Expectancy_db;
USE Life_Expectancy_db;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
  
SHOW TABLES;
DESCRIBE life_expectancy;
USE life_expectancy_db;

-- ----------------------------------------------------------------------------
-- 9. STAGING TABLE (raw CSV land zone -- not part of the final 3NF model)
-- ----------------------------------------------------------------------------
CREATE TABLE life_expectancy (
    Country                             VARCHAR(100),
    Year                                 SMALLINT,
    Status                               VARCHAR(20),
    life_expectancy                       DECIMAL(4,1),
    Adult_mortality                       DECIMAL(6,1),
    infant_deaths                         INT,
    Alcohol                               DECIMAL(6,2),
    percentage_expenditure                DECIMAL(14,4),
    Hepatitis_B                           DECIMAL(5,1),
    Measles                               INT,
    BMI                                   DECIMAL(5,1),
    under_five_deaths                     INT,
    Polio                                 DECIMAL(5,1),
    Total_Expenditure                     DECIMAL(5,2),
    Diphtheria                            DECIMAL(5,1),
    HIV_AIDS                              DECIMAL(5,2),
    GDP                                   DECIMAL(16,4),
    Population                            BIGINT,
    Thinness_1_19_Years                   DECIMAL(4,1),
    Thinness_5_9_Years                    DECIMAL(4,1),
    Income_Composition_of_Resources       DECIMAL(4,3),
    Schooling                             DECIMAL(4,1),
    Age_Group                             VARCHAR(20),
    GDP_Per_Person                        DECIMAL(16,6),
    Child_Mortality_Rate                  DECIMAL(14,6),
    Vaccination_Average                   DECIMAL(6,2),
    Healthcare_Score                      DECIMAL(8,3),
    BMI_Category                          VARCHAR(20),
    GDP_Category                          VARCHAR(20),
    Population_Million                    DECIMAL(14,4),
    High_HIV_Risk                         VARCHAR(20),
    Education_Level                       VARCHAR(20),
    Life_Expectancy_Rank                  INT,
    Country_Average_Life_Expectancy       DECIMAL(6,3),
    Year_Over_Year_Change                 DECIMAL(6,2),
    Health_Index                          DECIMAL(8,4),
    Mortality_Category                    VARCHAR(20)
) ENGINE=InnoDB;
 
-- -----------------------------------------------------------------------------------------------------------------------------------------------------
 SHOW VARIABLES LIKE 'local_infile';
 SHOW GLOBAL VARIABLES LIKE 'local_infile';
  
SHOW TABLES;
DESCRIBE life_expectancy;

SET GLOBAL local_infile = 1;
 
 -- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Load raw CSV into the staging table

LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Life Expectancy Data.csv'
INTO TABLE life_expectancy
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    Country,
    Year,
    Status,
    life_expectancy,
    Adult_mortality,
    infant_deaths,
    Alcohol,
    percentage_expenditure,
    @HepB,
    Measles,
    @BMI,
    under_five_deaths,
    @Polio,
    @TotExp,
    @Diph,
    HIV_AIDS,
    @GDP,
    @Population,
    @Thin1,
    @Thin2,
    @IncomeComp,
    @Schooling,
    Age_Group,
    GDP_Per_Person,
    Child_Mortality_Rate,
    Vaccination_Average,
    Healthcare_Score,
    BMI_Category,
    GDP_Category,
    Population_Million,
    High_HIV_Risk,
    Education_Level,
    @LERank,
    Country_Average_Life_Expectancy,
    @YoY,
    Health_Index,
    Mortality_Category
)
SET
    Hepatitis_B = NULLIF(@HepB, ''),
    BMI = NULLIF(@BMI, ''),
    Polio = NULLIF(@Polio, ''),
    Total_Expenditure = NULLIF(@TotExp, ''),
    Diphtheria = NULLIF(@Diph, ''),
    GDP = NULLIF(@GDP, ''),
    Population = NULLIF(@Population, ''),
    Thinness_1_19_Years = NULLIF(@Thin1, ''),
    Thinness_5_9_Years = NULLIF(@Thin2, ''),
    Income_Composition_of_Resources = NULLIF(@IncomeComp, ''),
    Schooling = NULLIF(@Schooling, ''),
    Life_Expectancy_Rank = NULLIF(@LERank, ''),
    Year_Over_Year_Change = NULLIF(@YoY, '');
    

-- -----------------------------------------------------------------------------------------------------------------------------
DESCRIBE life_expectancy;

SELECT COUNT(*) AS total_rows
FROM life_expectancy;

SHOW CREATE TABLE life_expectancy;

SELECT *
FROM life_expectancy
LIMIT 4000 ;


--  -----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  TABLE 2  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE healthcare_data (
    Country VARCHAR(100),
    Year INT,
    Status VARCHAR(30),
    Life_Expectancy DECIMAL(5,2),
    Adult_Mortality DECIMAL(10,2),
    Infant_Deaths INT,
    Alcohol DECIMAL(10,2),
    Percentage_Expenditure DECIMAL(15,4),
    Hepatitis_B DECIMAL(10,2),
    Measles INT,
    BMI DECIMAL(10,2),
    Under_Five_Deaths INT,
    Polio DECIMAL(10,2),
    Total_Expenditure DECIMAL(10,2),
    Diphtheria DECIMAL(10,2),
    HIV_AIDS DECIMAL(10,2),
    GDP DECIMAL(15,4),
    Population DECIMAL(20,2),
    Thinness_1_19_Years DECIMAL(10,2),
    Thinness_5_9_Years DECIMAL(10,2),
    Income_Composition_of_Resources DECIMAL(10,3),
    Schooling DECIMAL(10,2),
    Age_Group VARCHAR(30),
    GDP_Per_Person VARCHAR(50),
    Child_Mortality_Rate VARCHAR(50),
    Vaccination_Average VARCHAR(50),
    Healthcare_Score VARCHAR(50),
    BMI_Category VARCHAR(30),
    GDP_Category VARCHAR(30),
    Population_Million DECIMAL(20,6),
    High_HIV_Risk VARCHAR(20),
    Education_Level VARCHAR(30),
    Life_Expectancy_Rank DECIMAL(15,2),
    Country_Average_Life_Expectancy VARCHAR(50),
    Year_Over_Year_Change DECIMAL(10,2),
    Health_Index VARCHAR(50),
    Mortality_Category VARCHAR(30)
);

-- Load raw CSV into the staging table

LOAD DATA LOCAL INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Life Expectancy Data.csv'
INTO TABLE healthcare_data
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(
    Country,
    Year,
    Status,
    life_expectancy,
    Adult_mortality,
    infant_deaths,
    Alcohol,
    percentage_expenditure,
    @HepB,
    Measles,
    @BMI,
    under_five_deaths,
    @Polio,
    @TotExp,
    @Diph,
    HIV_AIDS,
    @GDP,
    @Population,
    @Thin1,
    @Thin2,
    @IncomeComp,
    @Schooling,
    Age_Group,
    GDP_Per_Person,
    Child_Mortality_Rate,
    Vaccination_Average,
    Healthcare_Score,
    BMI_Category,
    GDP_Category,
    Population_Million,
    High_HIV_Risk,
    Education_Level,
    @LERank,
    Country_Average_Life_Expectancy,
    @YoY,
    Health_Index,
    Mortality_Category
)
SET
    Hepatitis_B = NULLIF(@HepB, ''),
    BMI = NULLIF(@BMI, ''),
    Polio = NULLIF(@Polio, ''),
    Total_Expenditure = NULLIF(@TotExp, ''),
    Diphtheria = NULLIF(@Diph, ''),
    GDP = NULLIF(@GDP, ''),
    Population = NULLIF(@Population, ''),
    Thinness_1_19_Years = NULLIF(@Thin1, ''),
    Thinness_5_9_Years = NULLIF(@Thin2, ''),
    Income_Composition_of_Resources = NULLIF(@IncomeComp, ''),
    Schooling = NULLIF(@Schooling, ''),
    Life_Expectancy_Rank = NULLIF(@LERank, ''),
    Year_Over_Year_Change = NULLIF(@YoY, '');
    
    
    DESCRIBE healthcare_data;

SELECT COUNT(*) AS total_rows
FROM healthcare_data;

SHOW CREATE TABLE healthcare_data;

SELECT *
FROM healthcare_data
LIMIT 4000 ;

    
-- -------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Query 1: Total records imported
SELECT COUNT(*) AS total_records FROM life_expectancy;

-- How many countries are represented?
SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM life_expectancy;

-- What years are available?
SELECT
MIN(year) AS First_Year,
MAX(year) AS Last_Year
from life_expectancy;

-- Check duplicate country-year records 

SELECT 
Country,
Year,
    COUNT(*) AS Record_Count
FROM life_expectancy
GROUP BY Country, Year
HAVING COUNT(*) > 1;

-- Find missing values
SELECT 
SUM(CASE WHEN life_expectancy IS NULL THEN 1 ELSE 0 END) AS Misssing_Life_Expectancy,
SUM(CASE WHEN Adult_mortality IS NULL THEN 1 ELSE 0 END ) AS Missing_Adult_Mortality,
SUM( CASE WHEN GDP IS NULL THEN 1 ELSE 0 END ) AS Misssing_GDP,
SUM(CASE WHEN Population IS NULL THEN 1 ELSE 0 END ) AS Missing_Population,
SUM(CASE WHEN Schooling IS NULL THEN 1 ELSE 0 END ) AS Missing_Schooling,
SUM(CASE WHEN BMI IS NULL  THEN 1 ELSE 0 END ) AS Missing_BMI
FROM life_expectancy;

-- ************************* BASIC SQL ANALYSIS ******************************** 
-- Avrage global life expectancy  >>>>>>>>>>>>>>>>>>>>>>>>>>
select
round(avg (life_expectancy), 2) As Avrage_Global_Life_Expectancy
from life_expectancy;

-- Minimum and maximum Life expectancy
select
min(life_expectancy) as Minmum_Life_Expenctancy,
max(life_expectancy) as Maximum_life_Expenctancy
from life_expectancy;

-- Top 10 countries by life expectancy
SELECT
    Country,
    ROUND(AVG(Life_Expectancy), 2) AS Avg_Life_Expectancy
FROM life_expectancy
GROUP BY Country
ORDER BY Avg_Life_Expectancy DESC
LIMIT 10;

-- Bottom 10 Countries
SELECT
    Country,
    ROUND(AVG(Life_Expectancy), 2) AS Avg_Life_Expectancy
FROM life_expectancy
GROUP BY Country
ORDER BY Avg_Life_Expectancy
LIMIT 10;

-- PART C - STATUS ANALYSIS 
-- Developing VS Developed countries ( Do develop Countries have substanitially life expectancy ?)
select
count(distinct Country) AS Countries,
round(avg(life_expectancy),2) AS Avg_Life_Expectancy,
round(avg(GDP),2) AS Avg_GDP,
round(avg(Schooling),2) AS Avg_Schooling
from life_expectancy
group by Status
order by Avg_Life_Expectancy desc;

--  ******************** YEARLY ANALYSIS ***************************************
-- Global life expectancy by year 
select
Year,
round(avg(life_expectancy), 2) AS Avg_Life_Expectancy
from life_expectancy
group by Year
order by Year;

-- Yearly change
select
Year,
round(avg(life_expectancy),2) as Avg_Life_Expectancy,
round(
avg(life_expectancy)-
lag(avg(life_expectancy)) over(order by Year),
2
) As Yearly_Change
from life_expectancy
group by year
order by year


-- **********************  MORTALITY ANALYSIS ************************************
-- Countries with highest adult mortality (Top 10)
select
Country,
round(avg(Adult_Mortality),2) AS Avg_Adult_Mortality
from life_expectancy
group by Country
ORDER BY Avg_Adult_Mortality DESC
LIMIT 10;

-- Life expectancy VS adult mortality
SELECT
    ROUND(AVG(Life_Expectancy), 2) AS Avg_Life_Expectancy,
    ROUND(AVG(Adult_Mortality), 2) AS Avg_Adult_Mortality
FROM life_expectancy;

-- correlation
SELECT
    ROUND(
        (COUNT(*) * SUM(Life_Expectancy * Adult_Mortality)
        - SUM(Life_Expectancy) * SUM(Adult_Mortality))
        /
        SQRT(
            (COUNT(*) * SUM(POW(Life_Expectancy,2))
            - POW(SUM(Life_Expectancy),2))
            *
            (COUNT(*) * SUM(POW(Adult_Mortality,2))
            - POW(SUM(Adult_Mortality),2))
        ),
        3
    ) AS Correlation
FROM life_expectancy
WHERE Life_Expectancy IS NOT NULL
AND Adult_Mortality IS NOT NULL;


-- ********************************   CHID MORTALITY **************************************
-- Countries with highest child mortality

select
Country,
round(avg(cast(Child_Mortality_Rate AS DECIMAL(15,6))),2)
AS Avg_Child_Mortality
from life_expectancy
where Child_Mortality_Rate regexp '^[0-9.]+$'
group by Country
order by Avg_Child_Mortality DESC
limit 10;


-- ********************* VACCINATION ANALYSIS **************************************
-- Average vaccination covrage

select
round(avg(cast(Vaccination_Average AS DECIMAL (10,2))),2)
AS Avg_Vaccination_Coverage
from life_expectancy
where Vaccination_Average regexp'^[0-9.]+$'


-- Countries with low vaccination covrage 
SELECT
    Country,
    ROUND(
        AVG(CAST(Vaccination_Average AS DECIMAL(10,2))), 
        2
    ) AS Avg_Vaccination
FROM life_expectancy
WHERE Vaccination_Average REGEXP '^[0-9.]+$'
GROUP BY Country
HAVING Avg_Vaccination < 60
ORDER BY Avg_Vaccination;

--  ********************** GDP ANALYSIS  ************************************************************
-- Countries with highest GDP
select
Country,
round(avg(GDP),2) AS Avg_GDP
from life_expectancy
where GDP IS NOT NULL
group by Country
order by Avg_GDP
LIMIT 10;

-- GDP category analysis

select 
GDP_Category,
count(*) AS Records,
round(avg(life_expectancy), 2) AS Avg_Life_Expectancy,
round(avg(Schooling),2) AS Avg_Schooling
from life_expectancy
group by GDP_Category 
order by Avg_Life_Expectancy desc;

--  ******************************** EDUCATION ANALYSIS********************************
-- Does schooling relate to life expectancy?
select
Education_Level,
round(avg(Schooling), 2) AS Avg_Schooling,
round(avg(life_expectancy),2) AS Avg_Life_Expectancy
from life_expectancy
group by Education_Level
order by Avg_Life_Expectancy desc;

-- ********************************* HEALTH INDEX *****************************************
select
Country,
round(
Avg(cast(Health_Index  AS DECIMAL (15,6))),
3
) As Avg_Health_Index
from life_expectancy
where Health_Index regexp '^[0-9.]+$'
group by Country
order by Avg_Health_Index desc
limit 10;

-- ADVANCED  analyze  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- Rank countries by life expectancy

SELECT
    Country,
    ROUND(AVG(Life_Expectancy), 2) AS Avg_Life_Expectancy,
    RANK() OVER (
        ORDER BY AVG(Life_Expectancy) DESC
    ) AS Country_Rank
FROM life_expectancy
GROUP BY Country;

-- Top 3 countries per year
with country_year as
(
  select 
  Country,
  Year,
  avg(life_expectancy) AS Avg_Life_Expectancy
  from life_expectancy
  group by Country,Year
  ),
  ranked AS
  (
    select
    *,
    dense_rank() over(
    partition by Year
    order by Avg_Life_Expectancy DESC
    ) as Rank_No
    FROM country_year
    )
    select * 
    from ranked
    where Rank_No <= 3
ORDER BY Year, Rank_No;

-- BUSINESS-LEVEL Analysis 

-- Which countries consistently perform well in life expectancy?
SELECT
    Country,
    COUNT(*) AS Years_Observed,
    ROUND(AVG(Life_Expectancy), 2) AS Avg_Life_Expectancy,
    ROUND(MIN(Life_Expectancy), 2) AS Minimum,
    ROUND(MAX(Life_Expectancy), 2) AS Maximum
FROM life_expectancy
GROUP BY Country
HAVING COUNT(*) >= 5
ORDER BY Avg_Life_Expectancy DESC
LIMIT 15;

-- Which countries have high GDP but relatively low life expectancy?
  
  WITH country_stats AS
(
    SELECT
        Country,
        AVG(GDP) AS Avg_GDP,
        AVG(Life_Expectancy) AS Avg_Life_Expectancy
    FROM life_expectancy
    GROUP BY Country
),
thresholds AS
(
    SELECT
        AVG(Avg_GDP) AS GDP_Benchmark,
        AVG(Avg_Life_Expectancy) AS Life_Benchmark
    FROM country_stats
)
SELECT
    c.Country,
    ROUND(c.Avg_GDP,2) AS Avg_GDP,
    ROUND(c.Avg_Life_Expectancy,2) AS Avg_Life_Expectancy
FROM country_stats c
CROSS JOIN thresholds t
WHERE c.Avg_GDP > t.GDP_Benchmark
AND c.Avg_Life_Expectancy < t.Life_Benchmark
ORDER BY c.Avg_GDP DESC;


-- Which countries improved the most?
select
Country,
min(Year) as First_Year,
max(Year) as Last_Year,
round(
max(life_expectancy) - min (life_expectancy),
2
) as Life_Expenctancy_Improvement 
from life_expectancy
group by Country
having count(*) >= 5
order by life_expectancy_Improvement desc
limit 15;

SELECT
    Country,
    MIN(Year) AS First_Year,
    MAX(Year) AS Last_Year,
    ROUND(
        MAX(Life_Expectancy) - MIN(Life_Expectancy),
        2
    ) AS Life_Expectancy_Improvement
FROM life_expectancy
GROUP BY Country
HAVING COUNT(*) >= 5
ORDER BY Life_Expectancy_Improvement DESC
LIMIT 15;

-- Which countries have high HIV/AIDS risk and low life expectancy?

SELECT
    Country,
    ROUND(
        AVG(CAST(Vaccination_Average AS DECIMAL(10,2))),
        2
    ) AS Vaccination,
    ROUND(AVG(Life_Expectancy),2) AS Life_Expectancy
FROM life_expectancy
WHERE Vaccination_Average REGEXP '^[0-9.]+$'
GROUP BY Country
HAVING Vaccination > 80
AND Life_Expectancy < 65
ORDER BY Vaccination DESC;

-- Which countries have strong vaccination but weak life expectancy?

select 
Country,
round(
Avg(cast(Vaccination_Average AS decimal (10,2))),
2
) As Vaccination,
round(avg(Life_Expectancy),2) as Life_Expectancy
from life_expectancy
where Vaccination_Average REGEXP '^[0-9.]+$'
group by Country
having Vaccination > 80
and life_expectancy < 65
order by Vaccination desc;

-- **********************************************************************************************************
-- PROJECT 2 —  Healthcare Performance & Country Risk Analytics  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
-- *****************************************************************************************************
-- Healthcare performance by country
SELECT
    Country,
    ROUND(AVG(Life_Expectancy),2) AS Avg_Life_Expectancy,
    ROUND(AVG(Adult_Mortality),2) AS Avg_Adult_Mortality,
    ROUND(AVG(Schooling),2) AS Avg_Schooling,
    ROUND(
        AVG(CAST(Healthcare_Score AS DECIMAL(10,3))),
        3
    ) AS Avg_Healthcare_Score
FROM healthcare_data
WHERE Healthcare_Score REGEXP '^[0-9.]+$'
GROUP BY Country
ORDER BY Avg_Healthcare_Score DESC; 

-- Healthcare score by country status
select
Status,
round(
avg(cast(Healthcare_Score as decimal(10,3))),
3
) as Avg_Healthcare_Score,
round(avg(life_expectancy),2) as Avg_Life_Expectancy,
round(avg(Adult_mortality),2) as Avg_Adult_Morlality
from healthcare_data
where Healthcare_Score REGEXP '^[0-9.]+$'
group by Status;

-- Which countries should receive priority healthcare intervention?
select
Country,
round(avg(life_expectancy),2) as Life_Expectancy,
round(avg(HIV_AIDS),2) as HIV_Risk,
round(avg(Adult_mortality),2) as Adult_Mortality,
round(
avg(cast(Vaccination_Average as decimal(10,2))),
2
) as Vaccination
from healthcare_data
where  Vaccination_Average REGEXP '^[0-9.]+$'
group by Country
having life_expectancy < 65
and Adult_Mortality > 200
order by Adult_Mortality desc;


     -- Vaccination effectiveness analysis
select
   Country,
   round(
   avg(cast(Vaccination_Average as decimal (10,2))),
   2
   ) as Vaccination,
   round(avg(life_expectancy),2) as  Life_Expectancy,
   round(avg(infant_deaths),2) as Infant_Deaths
   FROM healthcare_data
WHERE Vaccination_Average REGEXP '^[0-9.]+$'
GROUP BY Country
ORDER BY Vaccination DESC;

-- Healthcare priority score

select
Country,
round(avg(life_expectancy),2) as Life_Expectancy,
round(avg(Adult_mortality),2) as Adult_Morlatity,
round(
avg(cast(Vaccination_Average as decimal (10,2))),
2
) as Vaccination,
round(
avg(cast(Healthcare_Score as decimal(10,3))),
3
) as Healthcare_Score,

case
when avg(life_expectancy) < 60
and avg(Adult_mortality) > 250 
then 'CRITICAL'
when avg(life_expectancy) < 65
and avg(Adult_mortality) > 200 
then 'HIGH'
when avg(life_expectancy) < 70
then 'MEDIUM'

else 'LOW'
    END AS Healthcare_Risk

FROM healthcare_data
WHERE Vaccination_Average REGEXP '^[0-9.]+$'
AND Healthcare_Score REGEXP '^[0-9.]+$'
GROUP BY Country
ORDER BY
    CASE Healthcare_Risk
        WHEN 'CRITICAL' THEN 1
        WHEN 'HIGH' THEN 2
        WHEN 'MEDIUM' THEN 3
        WHEN 'LOW' THEN 4
    END;
    
-- Infant mortality analysis (top 20)
select
Country,
round(avg(Life_Expectancy),2) as Avg_Life_Expectancy,
round(avg(Infant_Deaths),2) as Avg_Infant_Deaths
from healthcare_data
group by Country
order by Avg_Infant_Deaths desc
limit 20 ;

-- Measles burden
select
Country,
sum(Measles) as Total_Meals_Cases
from healthcare_data
group by Country
order by Total_Meals_Cases desc
;

--  Countries with high measles and low vaccination
select 
Country,
sum(Measles) as Total_Measles,
round(avg(cast(Vaccination_Average as decimal (10,2))),2) as Avg_Vaccination
from healthcare_data
where Vaccination_Average REGEXP '^[0-9.]+$'
group by Country
having Total_Measles > 1000
and Avg_Vaccination < 70
order by Total_Measles desc;

--  Education-healthcare relationship
select
Education_Level,
round(avg(Schooling),2) as Avg_Schooling,
round(avg(Life_Expectancy),2 ) AS Avg_Life_Expectancy,
round(avg(Adult_Mortality),2) as  Avg_Adult_Mortality
from healthcare_data
group by Education_Level
order by  Avg_Life_Expectancy DESC;

-- BMI category analysis
SELECT
    BMI_Category,
    COUNT(*) AS Records,
    ROUND(AVG(Life_Expectancy),2) AS Avg_Life_Expectancy,
    ROUND(AVG(Adult_Mortality),2) AS Avg_Adult_Mortality
FROM healthcare_data
GROUP BY BMI_Category
ORDER BY Avg_Life_Expectancy DESC;

--    BUSINESS SQL

-- Which countries need the highest healthcare investment?
SELECT
    Country,
    ROUND(AVG(Life_Expectancy),2) AS Life_Expectancy,
    ROUND(AVG(Adult_Mortality),2) AS Adult_Mortality,
    ROUND(AVG(GDP),2) AS GDP,
    ROUND(
        AVG(CAST(Healthcare_Score AS DECIMAL(10,3))),
        3
    ) AS Healthcare_Score
FROM healthcare_data
WHERE Healthcare_Score REGEXP '^[0-9.]+$'
GROUP BY Country
HAVING Life_Expectancy < 60
AND Adult_Mortality > 250
ORDER BY Adult_Mortality DESC;

--  Which countries are high-performing despite low GDP?
WITH country_metrics AS
(
    SELECT
        Country,
        AVG(GDP) AS GDP,
        AVG(Life_Expectancy) AS Life_Expectancy
    FROM healthcare_data
    GROUP BY Country
),
benchmarks AS
(
    SELECT
        AVG(GDP) AS Avg_GDP,
        AVG(Life_Expectancy) AS Avg_Life
    FROM country_metrics
)
SELECT
    c.Country,
    ROUND(c.GDP,2) AS Avg_GDP,
    ROUND(c.Life_Expectancy,2) AS Avg_Life_Expectancy
FROM country_metrics c
CROSS JOIN benchmarks b
WHERE c.GDP < b.Avg_GDP
AND c.Life_Expectancy > b.Avg_Life
ORDER BY c.Life_Expectancy DESC;

-- Which countries improved year over year?
SELECT
    Country,
    Year,
    Life_Expectancy,
    Year_Over_Year_Change
FROM healthcare_data
WHERE Year_Over_Year_Change > 0
ORDER BY Year_Over_Year_Change DESC;

-- Which countries experienced deterioration?
SELECT
    Country,
    Year,
    Life_Expectancy,
    Year_Over_Year_Change
FROM healthcare_data
WHERE Year_Over_Year_Change < 0
ORDER BY Year_Over_Year_Change ASC;

-- Identify countries with strong healthcare but weak education
SELECT
    Country,
    ROUND(AVG(Schooling),2) AS Schooling,
    ROUND(
        AVG(CAST(Healthcare_Score AS DECIMAL(10,3))),
        3
    ) AS Healthcare_Score,
    ROUND(AVG(Life_Expectancy),2) AS Life_Expectancy
FROM healthcare_data
WHERE Healthcare_Score REGEXP '^[0-9.]+$'
GROUP BY Country
HAVING Schooling < 10
AND Healthcare_Score > 5
ORDER BY Healthcare_Score DESC;

-- Country's yearly improvement
SELECT
    Country,
    Year,
    Life_Expectancy,

    LAG(Life_Expectancy) OVER (
        PARTITION BY Country
        ORDER BY Year
    ) AS Previous_Year,

    ROUND(
        Life_Expectancy -
        LAG(Life_Expectancy) OVER (
            PARTITION BY Country
            ORDER BY Year
        ),
        2
    ) AS Change_From_Previous_Year

FROM healthcare_data
ORDER BY Country, Year;


-- COUNTRY PERFORMANCE
WITH country_performance AS
(
    SELECT
        Country,
        AVG(Life_Expectancy) AS Life_Expectancy,
        AVG(Adult_Mortality) AS Mortality,
        AVG(Schooling) AS Schooling
    FROM healthcare_data
    GROUP BY Country
)

SELECT
    Country,
    ROUND(Life_Expectancy,2) AS Life_Expectancy,
    ROUND(Mortality,2) AS Mortality,
    ROUND(Schooling,2) AS Schooling,

    CASE
        WHEN Life_Expectancy >= 75
             AND Mortality < 150
            THEN 'Excellent'

        WHEN Life_Expectancy >= 70
             AND Mortality < 200
            THEN 'Good'

        WHEN Life_Expectancy >= 60
            THEN 'Moderate'

        ELSE 'Needs Improvement'
    END AS Performance_Level

FROM country_performance
ORDER BY Life_Expectancy DESC;


