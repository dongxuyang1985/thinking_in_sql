-- 第 11 篇练习题参考答案
-- 编写 SQL 语句查询员工信息，按照部门编号进行排序，并且确保同一个部门中的女性员工排在男性员工之前。

-- 在 ORDER BY 中利用 CASE 函数明确指定同一个部门中的女性员工排在男性员工之前。
SELECT dept_id, emp_name, sex
  FROM employee
 ORDER BY dept_id,
       CASE sex
         WHEN '女' THEN 0
         ELSE 1
       END;
