-- 第 6 篇练习题参考答案
-- 查询所有的员工信息，按照员工的总收入（年薪加奖金）从高到低进行排序，总收入相同再按照姓名的拼音顺序排序。

-- Oracle 实现
SELECT *
  FROM employee
 ORDER BY salary * 12 + COALESCE(bonus, 0) DESC, NLSSORT(emp_name,'NLS_SORT = SCHINESE_PINYIN_M');

-- MySQL 实现
SELECT *
  FROM employee
 ORDER BY salary * 12 + COALESCE(bonus, 0) DESC, CONVERT(emp_name USING GBK);

-- SQL Server 实现
SELECT *
  FROM employee
 ORDER BY salary * 12 + COALESCE(bonus, 0) DESC, emp_name COLLATE Chinese_PRC_CI_AI_WS;

-- PostgreSQL 实现
SELECT *
  FROM employee
 ORDER BY salary * 12 + COALESCE(bonus, 0) DESC, emp_name COLLATE "zh_CN";
