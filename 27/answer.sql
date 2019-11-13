-- 第 27 篇练习题参考答案
-- 练习题 1：以下语句能不能执行成功，为什么？

-- SELECT *
DELETE
  FROM department
 WHERE dept_id = 5;

-- 以上语句将会返回违反外键约束的错误。
-- 因为它的子表 employee 中存在部门编号为 5 的记录；如果删除了部门表中的记录，员工中的这些员工就会属于一个不存在的部门。

-- 如何处理这种情况？
-- 方法 1：先删除 employee 表中的记录，再删除 department 表中的记录
-- SELECT *
DELETE
  FROM employee
 WHERE dept_id = 5;

-- SELECT *
DELETE
  FROM department
 WHERE dept_id = 5;

-- 方法 2：利用外键约束的自动级联删除功能，需要修改创建 employee 表时的外键属性
CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES department(dept_id) ON DELETE CASCADE


-- 练习题 2：尝试修改 emp_merge 中的某些数据，然后再次运行上面合并数据的示例，看看执行更新分支语句的结果。
UPDATE emp_merge
   SET salary = 8000,
       email = 'N/A'
  WHERE emp_name = '孙尚香';

SELECT * FROM emp_merge;

-- 然后再次执行 MERGE 或者 INSERT DUPLICATE KEY、INSERT ON CONFLICT 语句，之后验证 emp_merge 中的数据更新情况
SELECT * FROM emp_merge;
