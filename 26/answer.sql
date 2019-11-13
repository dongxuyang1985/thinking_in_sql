-- 第 26 篇思考题参考答案
-- 使用 DROP TABLE 语句删除 department 表，能不能成功执行？为什么？

-- 执行失败，因为employee 中存在引用 department 表的外键约束。
-- 可以先删除外键约束，然后再删除 department 表。

-- Oracle
-- DROP TABLE department CASCADE CONSTRAINTS; -- 自动级联删除外键约束
DROP TABLE department;
SQL Error [2449] [72000]: ORA-02449: unique/primary keys in table referenced by foreign keys

-- MySQL
DROP TABLE department;
SQL Error [3730] [HY000]: Cannot drop table 'department' referenced by a foreign key constraint 'fk_emp_dept' on table 'employee'.

-- SQL Server
DROP TABLE department;
SQL Error [3726] [S0001]: Could not drop object 'department' because it is referenced by a FOREIGN KEY constraint.

-- PostgreSQL
-- DROP TABLE department CASCADE; -- 自动级联删除外键约束
DROP TABLE department;
SQL Error [2BP01]: ERROR: cannot drop table department because other objects depend on it
  Detail: constraint fk_emp_dept on table employee depends on table department
view emp_detail depends on table department
  Hint: Use DROP ... CASCADE to drop the dependent objects too.
