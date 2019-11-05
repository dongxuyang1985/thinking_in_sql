-- 第 10 篇练习题参考答案
-- 如何知道今天或者某一天是星期几？可以查找数据库文档或者在网上搜索相关的函数。
-- 利用数据库提供的日期函数。

-- MySQL 实现
SELECT DAYNAME(CURRENT_DATE), DAYOFWEEK(CURRENT_DATE)
  FROM employee
 WHERE emp_id = 1;

-- SQL Server 实现
SELECT DATENAME(Weekday, GETDATE()), DATEPART(Weekday, GETDATE())
  FROM employee
 WHERE emp_id = 1;

-- Oracle 和 PostgreSQL 实现
SELECT TO_CHAR(CURRENT_DATE, 'Day'), TO_CHAR(CURRENT_DATE,'D')
  FROM employee
 WHERE emp_id = 1;
