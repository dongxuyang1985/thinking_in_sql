-- 第 12 篇练习题参考答案
-- 编写 SQL 语句统计每个部门中的人数，一个部门显示为一列，返回下面的结果：
行政管理部|人力资源部|财务部|研发部|销售部|保卫部|
---------|---------|------|-----|------|-----|
        3|        3|     2|    9|     8|    0|

-- 利用聚合函数和 CASE 表达式实现行转列
SELECT COUNT(CASE dept_id WHEN 1 THEN 1 ELSE NULL END) "行政管理部",
       COUNT(CASE dept_id WHEN 2 THEN 1 ELSE NULL END) "人力资源部",
       COUNT(CASE dept_id WHEN 3 THEN 1 ELSE NULL END) "财务部",
       COUNT(CASE dept_id WHEN 4 THEN 1 ELSE NULL END) "研发部",
       COUNT(CASE dept_id WHEN 5 THEN 1 ELSE NULL END) "销售部",
       COUNT(CASE dept_id WHEN 6 THEN 1 ELSE NULL END) "保卫部"
  FROM employee;
