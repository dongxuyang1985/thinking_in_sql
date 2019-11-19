-- 创建 employee_json 表，使用 JSON 数据类型存储员工的信息
-- MySQL 和 PostgreSQL 实现
CREATE TABLE employee_json(
  emp_id    INTEGER NOT NULL PRIMARY KEY,
  emp_info  JSON NOT NULL
);

-- Oracle
CREATE TABLE employee_json(
  emp_id    INTEGER NOT NULL PRIMARY KEY,
  emp_info  VARCHAR2(4000) NOT NULL CHECK (emp_info IS JSON)
);

-- SQL Server
CREATE TABLE employee_json(
  emp_id    INTEGER NOT NULL PRIMARY KEY,
  emp_info  VARCHAR(MAX) NOT NULL CHECK ( ISJSON(emp_info)>0 )
);

-- 生成初始化数据
INSERT INTO employee_json VALUES (1, '{"emp_name": "刘备", "sex": "男", "dept_id": 1, "manager": null, "hire_date": "2000-01-01", "job_id": 1, "income": [{"salary":30000}, {"bonus": 10000}], "email": "liubei@shuguo.com"}');
INSERT INTO employee_json VALUES (2, '{"emp_name": "关羽", "sex": "男", "dept_id": 1, "manager": 1, "hire_date": "2000-01-01", "job_id": 2, "income": [{"salary":26000}, {"bonus": 10000}], "email": "guanyu@shuguo.com"}');
INSERT INTO employee_json VALUES (3, '{"emp_name": "张飞", "sex": "男", "dept_id": 1, "manager": 1, "hire_date": "2000-01-01", "job_id": 2, "income": [{"salary":24000}, {"bonus": 10000}], "email": "zhangfei@shuguo.com"}');
INSERT INTO employee_json VALUES (4, '{"emp_name": "诸葛亮", "sex": "男", "dept_id": 2, "manager": 1, "hire_date": "2006-03-15", "job_id": 3, "income": [{"salary":24000}, {"bonus": 8000}], "email": "zhugeliang@shuguo.com"}');
INSERT INTO employee_json VALUES (5, '{"emp_name": "黄忠", "sex": "男", "dept_id": 2, "manager": 4, "hire_date": "2008-10-25", "job_id": 4, "income": [{"salary":8000}, {"bonus": null}], "email": "huangzhong@shuguo.com"}');
INSERT INTO employee_json VALUES (6, '{"emp_name": "魏延", "sex": "男", "dept_id": 2, "manager": 4, "hire_date": "2007-04-01", "job_id": 4, "income": [{"salary":7500}, {"bonus": null}], "email": "weiyan@shuguo.com"}');
INSERT INTO employee_json VALUES (7, '{"emp_name": "孙尚香", "sex": "女", "dept_id": 3, "manager": 1, "hire_date": "2002-08-08", "job_id": 5, "income": [{"salary":12000}, {"bonus": 5000}], "email": "sunshangxiang@shuguo.com"}');
INSERT INTO employee_json VALUES (8, '{"emp_name": "孙丫鬟", "sex": "女", "dept_id": 3, "manager": 7, "hire_date": "2002-08-08", "job_id": 6, "income": [{"salary":6000}, {"bonus": null}], "email": "sunyahuan@shuguo.com"}');
INSERT INTO employee_json VALUES (9, '{"emp_name": "赵云", "sex": "男", "dept_id": 4, "manager": 1, "hire_date": "2005-12-19", "job_id": 7, "income": [{"salary":15000}, {"bonus": 6000}], "email": "zhaoyun@shuguo.com"}');
INSERT INTO employee_json VALUES (10,'{"emp_name": "廖化", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2009-02-17", "job_id": 8, "income": [{"salary":6500}, {"bonus": null}], "email": "liaohua@shuguo.com"}');
INSERT INTO employee_json VALUES (11,'{"emp_name": "关平", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2011-07-24", "job_id": 8, "income": [{"salary":6800}, {"bonus": null}], "email": "guanping@shuguo.com"}');
INSERT INTO employee_json VALUES (12,'{"emp_name": "赵氏", "sex": "女", "dept_id": 4, "manager": 9, "hire_date": "2011-11-10", "job_id": 8, "income": [{"salary":6600}, {"bonus": null}], "email": "zhaoshi@shuguo.com"}');
INSERT INTO employee_json VALUES (13,'{"emp_name": "关兴", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2011-07-30", "job_id": 8, "income": [{"salary":7000}, {"bonus": null}], "email": "guanxing@shuguo.com"}');
INSERT INTO employee_json VALUES (14,'{"emp_name": "张苞", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2012-05-31", "job_id": 8, "income": [{"salary":6500}, {"bonus": null}], "email": "zhangbao@shuguo.com"}');
INSERT INTO employee_json VALUES (15,'{"emp_name": "赵统", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2012-05-03", "job_id": 8, "income": [{"salary":6000}, {"bonus": null}], "email": "zhaotong@shuguo.com"}');
INSERT INTO employee_json VALUES (16,'{"emp_name": "周仓", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2010-02-20", "job_id": 8, "income": [{"salary":8000}, {"bonus": null}], "email": "zhoucang@shuguo.com"}');
INSERT INTO employee_json VALUES (17,'{"emp_name": "马岱", "sex": "男", "dept_id": 4, "manager": 9, "hire_date": "2014-09-16", "job_id": 8, "income": [{"salary":5800}, {"bonus": null}], "email": "madai@shuguo.com"}');
INSERT INTO employee_json VALUES (18,'{"emp_name": "法正", "sex": "男", "dept_id": 5, "manager": 2, "hire_date": "2017-04-09", "job_id": 9, "income": [{"salary":10000}, {"bonus": 5000}], "email": "fazheng@shuguo.com"}');
INSERT INTO employee_json VALUES (19,'{"emp_name": "庞统", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2017-06-06", "job_id": 10, "income": [{"salary":4100}, {"bonus": 2000}], "email": "pangtong@shuguo.com"}');
INSERT INTO employee_json VALUES (20,'{"emp_name": "蒋琬", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2018-01-28", "job_id": 10, "income": [{"salary":4000}, {"bonus": 1500}], "email": "jiangwan@shuguo.com"}');
INSERT INTO employee_json VALUES (21,'{"emp_name": "黄权", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2018-03-14", "job_id": 10, "income": [{"salary":4200}, {"bonus": null}], "email": "huangquan@shuguo.com"}');
INSERT INTO employee_json VALUES (22,'{"emp_name": "糜竺", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2018-03-27", "job_id": 10, "income": [{"salary":4300}, {"bonus": null}], "email": "mizhu@shuguo.com"}');
INSERT INTO employee_json VALUES (23,'{"emp_name": "邓芝", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2018-11-11", "job_id": 10, "income": [{"salary":4000}, {"bonus": null}], "email": "dengzhi@shuguo.com"}');
INSERT INTO employee_json VALUES (24,'{"emp_name": "简雍", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2019-05-11", "job_id": 10, "income": [{"salary":4800}, {"bonus": null}], "email": "jianyong@shuguo.com"}');
INSERT INTO employee_json VALUES (25,'{"emp_name": "孙乾", "sex": "男", "dept_id": 5, "manager": 18, "hire_date": "2018-10-09", "job_id": 10, "income": [{"salary":4700}, {"bonus": null}], "email": "sunqian@shuguo.com"}');
