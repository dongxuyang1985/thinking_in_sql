-- Oracle 实现
CREATE OR REPLACE TRIGGER tri_audit_salary
  AFTER UPDATE ON employee
  FOR EACH ROW
DECLARE
BEGIN
  -- 当月薪发生变化时，记录审计数据
  IF (:NEW.salary <> :OLD.salary) THEN
   INSERT INTO salary_audit (emp_id, old_salary, new_salary, change_date, change_by)
   VALUES(:OLD.emp_id, :OLD.salary, :NEW.salary, CURRENT_TIMESTAMP, USER);
  END IF;
END;

-- MySQL 实现
DELIMITER $$
CREATE TRIGGER tri_audit_salary
  AFTER UPDATE ON employee
  FOR EACH ROW
BEGIN
  -- 当月薪改变时，记录审计数据
  IF (NEW.salary <> OLD.salary) THEN
   INSERT INTO salary_audit (emp_id, old_salary, new_salary, change_date, change_by)
   VALUES(OLD.emp_id, OLD.salary, NEW.salary, CURRENT_TIMESTAMP, USER());
  END IF;
END$$
DELIMITER ;

-- SQL Server 实现
CREATE OR ALTER TRIGGER tri_audit_salary
  ON employee
  AFTER UPDATE
AS
BEGIN
  -- INSERTED 和 DELETED 是 SQL Server 中两个专用于触发器的虚拟表，分别用于存储数据修改前后的数据
  INSERT INTO salary_audit (emp_id, old_salary, new_salary, change_date, change_by)
  SELECT OLD.emp_id, OLD.salary, NEW.salary, CURRENT_TIMESTAMP, USER
    FROM INSERTED NEW
    JOIN DELETED OLD ON (NEW.emp_id = OLD.emp_id)
   WHERE NEW.salary <> OLD.salary
END

-- PostgreSQL 实现
-- PostgreSQL 中创建触发器包含两个步骤：
-- 1. 创建一个函数，返回类型为 trigger；
CREATE OR REPLACE FUNCTION sf_audit_salary()
  RETURNS trigger
  LANGUAGE plpgsql
  AS
$$
begin
  -- 当月薪改变时，记录审计数据
  IF (NEW.salary <> OLD.salary) THEN
      INSERT INTO salary_audit (emp_id, old_salary, new_salary, change_date, change_by)
  VALUES(OLD.emp_id, OLD.salary, NEW.salary, CURRENT_TIMESTAMP, USER);
  END IF;

  -- 返回更新后的记录
  RETURN NEW;
END;
$$
-- 2. 创建一个触发器，执行函数。
CREATE TRIGGER tri_audit_salary
  AFTER UPDATE ON employee
  FOR EACH ROW
  EXECUTE PROCEDURE sf_audit_salary();


-- 验证触发器的效果
UPDATE employee
   SET email = 'sunqian@shuguo.net'
 WHERE emp_name = '孙乾';

UPDATE employee
   SET salary = salary * 1.1
 WHERE emp_name = '孙乾';

SELECT *
  FROM salary_audit;
