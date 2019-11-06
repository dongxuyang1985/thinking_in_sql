-- 第 13 篇练习题参考答案
-- 按照员工的性别和收入水平统计人数和平均月薪。
-- 收入小于 10000 为低收入，高于等于 10000 并且低于 20000 为中等收入，高于等于 20000 为高收入。实现以下查询结果：
性别|收入 |人数|平均月薪     |
---|-----|----|------------|
女 |低收入|   2| 6300.000000|
女 |中收入|   1|12000.000000|
男 |低收入|  16| 5762.500000|
男 |中收入|   2|12500.000000|
男 |高收入|   4|26000.000000|

-- 分别在 SELECT、 GROUP BY 和 ORDER BY 中使用 CASE 表达式
SELECT sex "性别", 
       CASE 
         WHEN salary < 10000  THEN '低收入'
         WHEN salary < 20000  THEN '中收入'
         ELSE '高收入'
       END "收入",
       COUNT(*) "人数", AVG(salary) "平均月薪"
  FROM employee
 GROUP BY sex,
       CASE 
         WHEN salary < 10000  THEN '低收入'
         WHEN salary < 20000  THEN '中收入'
         ELSE '高收入'
       END
 ORDER BY CASE sex WHEN '女' THEN 0 ELSE 1 END, AVG(salary);
