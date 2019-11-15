-- 第 32 篇练习题参考答案
-- 禁用触发器 tri_audit_salary，或者在 MySQL 中删除该触发器；
-- 然后将“孙乾”的月薪改回 4700。再次查看审计表 salary_audit，是否还会生成一条记录？

-- Oracle 实现
ALTER TRIGGER tri_audit_salary DISABLE;

-- SQL Server 实现
DISABLE TRIGGER tri_audit_salary ON employee;

-- PostgreSQL 实现
ALTER TABLE employee
DISABLE TRIGGER tri_audit_salary;

-- MySQL 不支持禁用触发器，只能将其删除
DROP TRIGGER tri_audit_salary;

-- 将“孙乾”的月薪改回 4700
UPDATE employee
   SET salary = 4700
 WHERE emp_name = '孙乾';

-- 审计表 salary_audit 不会生成新的记录
SELECT * FROM salary_audit;
AUDIT_ID|EMP_ID|OLD_SALARY|NEW_SALARY|CHANGE_DATE        |CHANGE_BY|
--------|------|----------|----------|-------------------|---------|
       1|    25|      4700|      5170|2019-10-18 10:16:36|TONY     |
