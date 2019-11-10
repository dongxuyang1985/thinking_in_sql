-- 第 19 篇练习题参考答案
-- 练习题 1：如何利用递归通用表表达式实现九九乘法表？

-- MySQL 以及 PostgreSQL 实现
WITH RECURSIVE t(n) AS
(
  SELECT 1
   UNION ALL
  SELECT n + 1 FROM t WHERE n < 9
)
SELECT CONCAT(t1.n, ' x ', t2.n, ' = ', t1.n * t2.n)
  FROM t t1
  JOIN t t2 ON (t1.n <= t2.n);

-- SQL Server 实现
WITH t(n) AS
(
  SELECT 1
   UNION ALL
  SELECT n + 1 FROM t WHERE n < 9
)
SELECT CONCAT(t1.n, ' x ', t2.n, ' = ', t1.n * t2.n)
  FROM t t1
  JOIN t t2 ON (t1.n <= t2.n);

-- Oracle 实现
WITH t(n) AS
(
  SELECT 1 FROM dual
   UNION ALL
  SELECT n + 1 FROM t WHERE n < 9
)
SELECT t1.n || ' x ' || t2.n || ' = ' || t1.n * t2.n
  FROM t t1
  JOIN t t2 ON (t1.n <= t2.n);

CONCAT(t1.n, ' x ', t2.n, ' = ', t1.n * t2.n)|
---------------------------------------------|
1 x 1 = 1                                    |
1 x 2 = 2                                    |
1 x 3 = 3                                    |
1 x 4 = 4                                    |
1 x 5 = 5                                    |
1 x 6 = 6                                    |
...
8 x 8 = 64                                   |
8 x 9 = 72                                   |
9 x 9 = 81                                   |


-- 练习题 2：假如存在以下销售数据表 sales：
CREATE TABLE sales(
  id       INT NOT NULL PRIMARY KEY, -- 主键
  saledate DATE NOT NULL, -- 销售日期
  amount   INT NOT NULL -- 销量
);

-- 只有 Oracle 需要执行以下 alter 语句
-- alter session set nls_date_format = 'YYYY-MM-DD';
INSERT INTO sales VALUES(1, '2019-01-01', 100);
INSERT INTO sales VALUES(2, '2019-01-03', 120);
INSERT INTO sales VALUES(3, '2019-01-04', 90);
INSERT INTO sales VALUES(4, '2019-01-06', 80);
INSERT INTO sales VALUES(5, '2019-01-08', 110);
INSERT INTO sales VALUES(6, '2019-01-10', 150);

-- 其中 2019 年 1 月 2 日、5 日、7 日以及 9 日没有销量。如何让查询的结果中显示出这些缺少的日期（销量显示为 0）？

-- MySQL 实现
WITH RECURSIVE dates (saledate) AS
(
  SELECT MIN(saledate) FROM sales
   UNION ALL
  SELECT saledate + INTERVAL '1' DAY FROM dates
   WHERE saledate + INTERVAL '1' DAY <= (SELECT MAX(saledate) FROM sales)
)
SELECT d.saledate "销售日期",
       COALESCE(s.amount, 0) "销量"
  FROM dates d
  LEFT JOIN sales s ON (d.saledate = s.saledate)
 ORDER BY d.saledate;

-- Oracle 实现
WITH dates (saledate) AS
(
  SELECT MIN(saledate) FROM sales
   UNION ALL
  SELECT saledate + INTERVAL '1' DAY FROM dates
   WHERE saledate + INTERVAL '1' DAY <= (SELECT MAX(saledate) FROM sales)
)
SELECT d.saledate "销售日期",
       COALESCE(s.amount, 0) "销量"
  FROM dates d
  LEFT JOIN sales s ON (d.saledate = s.saledate)
 ORDER BY d.saledate;

-- SQL Server 实现
-- SQL Server 不能在 CTE 的递归部分（UNION ALL 之后）使用聚合函数
WITH dates (saledate, maxdate) AS
(
  SELECT MIN(saledate), MAX(saledate) FROM sales
   UNION ALL
  SELECT DATEADD(DAY, 1, saledate), maxdate FROM dates
   WHERE DATEADD(DAY, 1, saledate) <= maxdate
)
SELECT d.saledate "销售日期",
       COALESCE(s.amount, 0) "销量"
  FROM dates d
  LEFT JOIN sales s ON (d.saledate = s.saledate)
 ORDER BY d.saledate;

-- PostgreSQL 实现，需要使用 CAST 函数将数据类型转换为日期
-- 因为 saledate + INTERVAL '1' DAY 的类型为 TIMESTAMP，PostgreSQL 对于数据类型要求比较高。
WITH RECURSIVE dates (saledate) AS
(
  SELECT MIN(saledate) FROM sales
   UNION ALL
  SELECT CAST(saledate + INTERVAL '1' DAY AS DATE) FROM dates
   WHERE CAST(saledate + INTERVAL '1' DAY AS DATE) <= (SELECT MAX(saledate) FROM sales)
)
SELECT d.saledate "销售日期",
       COALESCE(s.amount, 0) "销量"
  FROM dates d
  LEFT JOIN sales s ON (d.saledate = s.saledate)
 ORDER BY d.saledate;
 ORDER BY d.saledate;
 
 销售日期  |销量|
----------|----|
2019-01-01| 100|
2019-01-02|   0|
2019-01-03| 120|
2019-01-04|  90|
2019-01-05|   0|
2019-01-06|  80|
2019-01-07|   0|
2019-01-08| 110|
2019-01-09|   0|
2019-01-10| 150|
