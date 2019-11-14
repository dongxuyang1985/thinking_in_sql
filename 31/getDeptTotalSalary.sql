-- getDeptTotalSalary 获取部门的总月薪

-- 1. Oracle 实现
CREATE OR REPLACE FUNCTION getDeptTotalSalary (pn_dept_id INTEGER)
    RETURN NUMERIC
AS
    ln_total_salary NUMERIC;
BEGIN
    SELECT SUM(salary)
      INTO ln_total_salary
      FROM employee
     WHERE dept_id = pn_dept_id;
    
    RETURN ln_total_salary;
END;

-- 2. MySQL 实现
DELIMITER $$
CREATE FUNCTION getDeptTotalSalary (pn_dept_id INTEGER)
    RETURNS NUMERIC
    READS SQL DATA -- 表示只读取数据，不修改数据
BEGIN
	DECLARE ln_total_salary NUMERIC;

    SELECT SUM(salary)
      INTO ln_total_salary
      FROM employee
     WHERE dept_id = pn_dept_id;
    
    RETURN ln_total_salary;
END$$
DELIMITER ;

-- 3. SQL Server 实现
CREATE OR ALTER  FUNCTION getDeptTotalSalary (@pn_dept_id INTEGER)
    RETURNS NUMERIC
AS
BEGIN
    DECLARE @ln_total_salary NUMERIC
	
    SELECT @ln_total_salary = SUM(salary)
      FROM employee
     WHERE dept_id = @pn_dept_id
    
    RETURN @ln_total_salary
END

-- 4. PostgreSQL 实现
CREATE OR REPLACE FUNCTION getDeptTotalSalary (pn_dept_id INTEGER)
    RETURNS NUMERIC
    LANGUAGE PLPGSQL
AS $$
    DECLARE ln_total_salary NUMERIC;
BEGIN
    SELECT SUM(salary)
      INTO ln_total_salary
      FROM employee
     WHERE dept_id = pn_dept_id;
    
    RETURN ln_total_salary;
END;
$$

-- 5. 调用函数
SELECT dept_name, getDeptTotalSalary(dept_id)
  FROM department;
dept_name|getDeptTotalSalary(dept_id)|
---------|---------------------------|
行政管理部  |                      80000|
人力资源部  |                      39500|
财务部      |                      18000|
研发部      |                      68200|
销售部      |                      40100|
保卫部      |                           |
