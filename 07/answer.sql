-- 第 7 篇练习题参考答案
-- 使用 LIMIT 和 OFFSET 找出员工表中月薪排名第 3 高的所有员工。

-- MySQL 以及 PostgreSQL 实现
SELECT emp_name, salary
  FROM employee
 WHERE salary = (SELECT salary
                   FROM employee
                  ORDER BY salary DESC
                  LIMIT 1
                  OFFSET 2);

emp_name|salary  |
--------|--------|
张飞      |24000.00|
诸葛亮     |24000.00|
