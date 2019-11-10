-- 第 20 篇练习题参考答案
-- 编写一个查询语句，实现按照月份统计不同产品在不同渠道的销售金额小计，
-- 同时按照月份统计不同产品的销售金额合计，然后按照月份统计所有产品的销售金额合计，以及所有销售金额的总计。

-- Oracle 以及 PostgreSQL 实现
-- TO_CHAR 函数可以将日期转换为指定格式的字符串。
SELECT COALESCE(TO_CHAR(saledate, 'YYYYMM'), '所有月份') AS "月份",
       COALESCE(product, '所有产品') AS "产品",
       COALESCE(channel, '所有渠道') AS "渠道",
       SUM(amount) AS "销售金额"
  FROM sales_data
 WHERE channel IS NOT NULL
 GROUP BY ROLLUP (TO_CHAR(saledate, 'YYYYMM'), product, channel);

-- MySQL 实现
-- DATE_FORMAT 函数可以将日期转换为指定格式的字符串。
SELECT COALESCE(DATE_FORMAT(saledate, '%Y%m'), '所有月份') AS "月份",
       COALESCE(product, '所有产品') AS "产品",
       COALESCE(channel, '所有渠道') AS "渠道",
       SUM(amount) AS "销售金额"
  FROM sales_data
 WHERE channel IS NOT NULL
 GROUP BY COALESCE(DATE_FORMAT(saledate, '%Y%m'), '所有月份'), product, channel WITH ROLLUP;

-- SQL Server 实现
-- 使用 CONVERT(varchar(6), saledate, 112) 函数日期转换为指定格式的字符串。
SELECT COALESCE(CONVERT(varchar(6), saledate, 112), '所有月份') AS "月份",
       COALESCE(product, '所有产品') AS "产品",
       COALESCE(channel, '所有渠道') AS "渠道",
       SUM(amount) AS "销售金额"
  FROM sales_data
 WHERE channel IS NOT NULL
 GROUP BY ROLLUP (CONVERT(varchar(6), saledate, 112), product, channel);
 
 月份    |产品  |渠道  |销售金额   |
------|----|----|-------|
201901|桔子  |京东  |  38964|
201901|桔子  |店面  |  38981|
201901|桔子  |淘宝  |  41163|
201901|桔子  |所有渠道| 119108|
201901|苹果  |京东  |  35944|
201901|苹果  |店面  |  41520|
201901|苹果  |淘宝  |  40644|
201901|苹果  |所有渠道| 118108|
201901|香蕉  |京东  |  34554|
201901|香蕉  |店面  |  38885|
201901|香蕉  |淘宝  |  40143|
201901|香蕉  |所有渠道| 113582|
201901|所有产品|所有渠道| 350798|
...
201906|桔子  |京东  |  37824|
201906|桔子  |店面  |  34106|
201906|桔子  |淘宝  |  39801|
201906|桔子  |所有渠道| 111731|
201906|苹果  |京东  |  37220|
201906|苹果  |店面  |  40108|
201906|苹果  |淘宝  |  35019|
201906|苹果  |所有渠道| 112347|
201906|香蕉  |京东  |  35863|
201906|香蕉  |店面  |  42772|
201906|香蕉  |淘宝  |  34388|
201906|香蕉  |所有渠道| 113023|
201906|所有产品|所有渠道| 337101|
所有月份  |所有产品|所有渠道|2038632|
