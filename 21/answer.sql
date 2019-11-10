-- 第 21 篇练习题参考答案
-- 在上一篇的练习题 2 中，销售数据表 sales 在 2019 年 1 月 2 日、5 日、7 日以及 9 日没有销量。
-- 如何统计当然日期和前一天的累计销量？

-- 由于数据缺失，不能再使用使用窗口函数中的 ROW 选项；而需要使用 RANGE 选项指定日期范围。

-- Oracle、MySQL 和 PostgreSQL 实现
SELECT saledate "销售日期",
       amount "销量",
       SUM(amount) OVER (ORDER BY saledate RANGE INTERVAL '1' DAY PRECEDING) "两天累计销量"
  FROM sales
 ORDER BY saledate;

销售日期   |销量 |两天累计销量|
----------|-----|-----------|
2019-01-01|  100|        100|
2019-01-03|  120|        120|
2019-01-04|   90|        210|
2019-01-06|   80|         80|
2019-01-08|  110|        110|
2019-01-10|  150|        150|

-- SQL Server 中的 RANGE 选项只能是 UNBOUNDED 和 CURRENT ROW，不能指定一个具体的值。
-- 可以通过一个子查询实现相同的效果。
SELECT s.saledate "销售日期",
       s.amount "销量",
       (SELECT SUM(amount)
          FROM sales
         WHERE saledate BETWEEN DATEADD(DAY, -1, s.saledate) AND s.saledate ) "两天累计销量"
  FROM sales s
 ORDER BY s.saledate;
