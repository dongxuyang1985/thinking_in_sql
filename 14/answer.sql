-- 第 14 篇练习题参考答案
-- 编写 SQL 查询计算 2018 年度各个国家/地区的人口增长率。

--
SELECT country_name AS "国家/地区",
       SUM(CASE WHEN year = 2017 THEN population ELSE 0 END) AS "2017年人口",
       SUM(CASE WHEN year = 2018 THEN population ELSE 0 END) AS "2018年人口",
       (SUM(CASE WHEN year = 2018 THEN population ELSE 0 END)
        - SUM(CASE WHEN year = 2017 THEN population ELSE 0 END))/SUM(CASE WHEN year = 2017 THEN population ELSE 0 END) * 100 AS "2018 增长率（%）"
  FROM gdp_data
 WHERE year IN (2017, 2018) AND gdp IS NOT NULL
 GROUP BY country_name
 ORDER BY 4 DESC;
