-- 第 31 篇练习题参考答案
-- 创建 2 个存储过程，分别用于按照工号修改员工信息（update_employee_byid）以及删除员工信息（delete_employee_byid）。

-- 1. 创建存储过程 update_employee_byid
-- Oracle
CREATE OR REPLACE PROCEDURE update_employee_byid
( p_emp_id    IN INTEGER,
  p_emp_name  IN VARCHAR2,
  p_sex       IN VARCHAR2,
  p_dept_id   IN INTEGER,
  p_manager   IN INTEGER,
  p_hire_date IN DATE,
  p_job_id    IN INTEGER,
  p_salary    IN NUMERIC,
  p_bonus     IN NUMERIC,
  p_email     IN VARCHAR2)
AS
  ln_cnt INTEGER;
BEGIN
  -- 判断该员工是否存在
  SELECT COUNT(1)
    INTO ln_cnt
    FROM employee
   WHERE emp_id = p_emp_id;
  
  -- 员工不存在，返回异常错误
  IF (ln_cnt = 0) THEN
    raise_application_error(-20001, '员工不存在：' || p_emp_id);
  END IF;
  
  -- 更新员工信息
  UPDATE employee
     SET emp_name = p_emp_name,
         sex = p_sex,
         dept_id = p_dept_id,
         manager = p_manager,
         hire_date = p_hire_date,
         job_id = p_job_id,
         salary = p_salary,
         bonus = p_bonus,
         email = p_email
   WHERE emp_id = p_emp_id;
END;

-- 测试
CALL update_employee_byid(0, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com');
SQL Error [20001] [72000]: ORA-20001: 员工不存在：  0
ORA-06512: at "TONY.UPDATE_EMPLOYEE_BYID", line 22

CALL update_employee_byid(26, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com');
SELECT * FROM employee WHERE emp_id = 26;

-- MySQL
DELIMITER $$

CREATE PROCEDURE update_employee_byid
( IN p_emp_id    INTEGER,
  IN p_emp_name  VARCHAR(50),
  IN p_sex       VARCHAR(10),
  IN p_dept_id   INTEGER,
  IN p_manager   INTEGER,
  IN p_hire_date DATE,
  IN p_job_id    INTEGER,
  IN p_salary    NUMERIC(8,2),
  IN p_bonus     NUMERIC(8,2),
  IN p_email     VARCHAR(100))
BEGIN
  DECLARE ln_cnt INT;
  DECLARE msg VARCHAR(100);

  -- 判断该员工是否存在
  SELECT COUNT(1),CONCAT('员工不存在：', p_emp_id)
    INTO ln_cnt,msg
    FROM employee
   WHERE emp_id = p_emp_id;
  
  -- 员工不存在，返回异常错误
  IF (ln_cnt = 0) THEN
    SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = msg;
  END IF;
   
  -- 更新员工信息
  UPDATE employee
     SET emp_name = p_emp_name,
         sex = p_sex,
         dept_id = p_dept_id,
         manager = p_manager,
         hire_date = p_hire_date,
         job_id = p_job_id,
         salary = p_salary,
         bonus = p_bonus,
         email = p_email
   WHERE emp_id = p_emp_id;
END$$

DELIMITER ;

-- 测试
CALL update_employee_byid(0, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com');
SQL Error [1644] [45000]: 员工不存在：  0

CALL update_employee_byid(26, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com');
SELECT * FROM employee WHERE emp_id = 26;

-- SQL Server
CREATE OR ALTER PROCEDURE update_employee_byid
( @p_emp_id    INTEGER,
  @p_emp_name  VARCHAR(50),
  @p_sex       VARCHAR(10),
  @p_dept_id   INTEGER,
  @p_manager   INTEGER,
  @p_hire_date DATE,
  @p_job_id    INTEGER,
  @p_salary    NUMERIC(8,2),
  @p_bonus     NUMERIC(8,2),
  @p_email     VARCHAR(100))
AS
BEGIN
  DECLARE @ln_cnt INT
  DECLARE @msg VARCHAR(100)

  -- 判断该员工是否存在
  SELECT @ln_cnt = COUNT(1), @msg = '员工不存在： ' + CAST(@p_emp_id AS VARCHAR)
    FROM employee
   WHERE emp_id = @p_emp_id
  
  -- 员工不存在，返回异常错误
  IF (@ln_cnt = 0)
  BEGIN
    RAISERROR(@msg, 17, 1)
  END
   
  -- 更新员工信息
  UPDATE employee
     SET emp_name = @p_emp_name,
         sex = @p_sex,
         dept_id = @p_dept_id,
         manager = @p_manager,
         hire_date = @p_hire_date,
         job_id = @p_job_id,
         salary = @p_salary,
         bonus = @p_bonus,
         email = @p_email
   WHERE emp_id = @p_emp_id
END

-- 测试
EXEC update_employee_byid 0, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com';
SQL Error [50000] [S0001]: 员工不存在： 0

EXEC update_employee_byid 26, '李四', '男', 5, 18, '2019-12-31', 10, 7000, NULL, 'lisi@shuguo.com';
SELECT * FROM employee WHERE emp_id = 26;

-- PostgreSQL

-- 2. 创建存储过程 delete_employee_byid
-- Oracle
-- MySQL
-- SQL Server
-- PostgreSQL
