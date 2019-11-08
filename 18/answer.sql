-- 第 18 篇练习题参考答案
-- 本篇中我们分别给出了关于 INTERSECT、UNION 以及 EXCEPT 的三个示例，并且使用连接查询进行了改写。尝试一下哪些示例也可以使用子查询实现？

-- INTERSECT 示例用于查找 2018 年和 2019 年都是优秀员工的员工编号，
-- 可以使用以下子查询实现：
SELECT t1.emp_id
  FROM excellent_emp t1
 WHERE t1.year = 2018
   AND EXISTS (SELECT 1
                 FROM excellent_emp t2
                WHERE t2.year = 2019
                  AND t2.emp_id = t1.emp_id);

emp_id|
------|
     9|


-- UNION 操作符没有合适的子查询实现


-- EXCEPT 示例查找 2019 年被评为优秀，但是 2018 年不是优秀的员工，
-- 可以使用以下子查询实现：
SELECT t1.emp_id
  FROM excellent_emp t1
 WHERE t1.year = 2019
   AND NOT EXISTS (SELECT 1
                     FROM excellent_emp t2
                    WHERE t2.year = 2018
                      AND t2.emp_id = t1.emp_id);

emp_id|
------|
    20|
