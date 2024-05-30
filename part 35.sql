use tips;
create table happiness_index
(RankNo INT,
Country VARCHAR(250),
Happiness_2021 FLOAT,
Happiness_2022 FLOAT,
2022_Population INT);

SELECT * FROM happiness_index
ORDER BY Happiness_2022 DESC;

-- bring India to top from 136th Rank
SELECT * FROM (
	SELECT *,
		CASE WHEN Country = 'India' THEN 1
		ELSE 0 END AS Country_derived
		FROM happiness_index) happy
ORDER BY Country_derived DESC, Happiness_2022 DESC;

-- method 1
SELECT * FROM (
	SELECT *,
		CASE WHEN Country = 'India' THEN 3
		WHEN Country = 'Pakistan' Then 2
		WHEN Country = 'Sri Lanka' THEN 1
		ELSE 0 END AS Country_derived
		FROM happiness_index) happy
ORDER BY Country_derived DESC, Happiness_2022 DESC;

-- method 2
SELECT *
FROM happiness_index
ORDER BY CASE WHEN Country = 'India' THEN 3
		WHEN Country = 'Pakistan' Then 2
		WHEN Country = 'Sri Lanka' THEN 1
		ELSE 0 END DESC,  Happiness_2022 DESC;
        

        