-- 第 8 篇思考题参考答案
-- 如何实现查询语句，每次执行时从员工表中返回随机的 5 条不同的数据？
-- 原理就是利用一个生成随机数的函数为每行数据指定一个随机顺序，
-- 如果表中的数据量过大，这种方式可能存在性能问题。

-- Oracle 实现
SELECT *
  FROM employee
 ORDER BY DBMS_RANDOM.VALUE
 FETCH FIRST 5 ROWS ONLY;

-- MySQL 实现
SELECT *
  FROM employee
 ORDER BY RAND()
 LIMIT 5;

-- SQL Server 实现
-- SQL Server 中的 RAND() 函数对于一个查询语句中的所有行都返回相同的结果，
-- NEWID() 函数返回一个随机的 UUID。
SELECT *
  FROM employee
 ORDER BY NEWID()
 OFFSET 0 ROWS
 FETCH FIRST 5 ROWS ONLY;

-- PostgreSQL 实现
SELECT *
  FROM employee
 ORDER BY RANDOM()
 FETCH FIRST 5 ROWS ONLY;
