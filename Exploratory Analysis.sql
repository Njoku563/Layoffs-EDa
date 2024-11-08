-- Exploratory Data Analysis
select *
from layoffs_staging2;


select max(total_laid_off), MAX(Percentage_laid_off)
From layoffs_staging2;

select *
from layoffs_staging2
Where percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

SELECT Company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

select *
FROM layoffs_staging2;

SELECT YEAR (`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 2 DESC;

SELECT Stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Stage
ORDER BY 2 DESC;



select * from layoffs_staging2;

select location,industry,stage,substring(`date`,6,2)
from layoffs_staging2;

select Substring(`date`,6,2) as `MONTH`,SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY `MONTH`;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS Total_off
FROM layoffs_staging2 
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)

SELECT `MONTH`, Total_off,
SUM(Total_off) OVER(ORDER BY `MONTH`) AS Rolling_total
FROM Rolling_Total;
    
Select company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Company
ORDER BY 2 DESC;
    
Select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Company,YEAR(`date`)
ORDER BY Company ASC;

Select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Company,YEAR(`date`)
ORDER BY 3 DESC;


-- Top company that laid people off,year and their ranks
WITH Company_Year(company, years,total_laid_off) AS
(
Select company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY Company,YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
Select * 
FROM 
Company_Year_Rank
WHERE Ranking <= 5;













