-- 第 30 篇练习题参考答案
-- 练习题 1：创建一个关于员工信息的视图 emp_detail：

CREATE VIEW emp_detail(id, manager, dept_name, job_title, name, sex, email)
AS
SELECT e.emp_id, e.manager, d.dept_name, j.job_title, e.emp_name, e.sex, e.email
  FROM employee e
  JOIN department d ON (d.dept_id = e.dept_id)
  JOIN job j ON (j.job_id = e.job_id);

SELECT * FROM emp_detail ORDER BY id;
id|manager|dept_name|job_title|name|sex|email                   |
--|-------|---------|---------|----|---|------------------------|
 1|       |行政管理部    |总经理      |刘备  |男  |liubei@shuguo.com       |
 2|      1|行政管理部    |副总经理     |关羽  |男  |guanyu@shuguo.com       |
 3|      1|行政管理部    |副总经理     |张飞  |男  |zhangfei@shuguo.com     |
 4|      1|人力资源部    |人力资源总监   |诸葛亮 |男  |zhugeliang@shuguo.com   |
 5|      4|人力资源部    |人力资源专员   |黄忠  |男  |huangzhong@shuguo.com   |
 6|      4|人力资源部    |人力资源专员   |魏延  |男  |weiyan@shuguo.com       |
 ...
 
-- 以下语句能不能执行成功？

UPDATE developers_updatable
   SET dept_id = 5
 WHERE emp_name = '马岱';

-- 执行失败，返回与文中 INSERT 示例相同的错误
-- 如果使用 WITH CHECK OPTION 选项创建视图，针对视图执行的 UPDATE 语句同样也会进行数据的检查，确保不会导致数据更新后对视图不可见。

-- Oracle
SQL Error [1402] [44000]: ORA-01402: view WITH CHECK OPTION where-clause violation

-- MySQL
SQL Error [1369] [HY000]: CHECK OPTION failed 'hrdb.developers_updatable'

-- SQL Server
SQL Error [550] [S0001]: The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.

-- PostgreSQL
SQL Error [44000]: ERROR: new row violates check option for view "developers_updatable"
  Detail: Failing row contains (17, 马岱, 男, 5, 9, 2014-09-16, 8, 5800.00, null, madai@shuguo.com).
