-- 第 15 篇练习题参考答案
-- 假设下面的 emp_contact 表中存储的是员工的联系电话，包括工作电话、移动电话、家庭电话以及紧急联系人电话：

CREATE TABLE emp_contact(
  emp_id          INT NOT NULL PRIMARY KEY,
  work_phone      VARCHAR(20),
  mobile_phone    VARCHAR(20),
  home_phone      VARCHAR(20),
  emergency_phone VARCHAR(20)
);

INSERT INTO emp_contact VALUES (1, '010-61231111', NULL, NULL, NULL);
INSERT INTO emp_contact VALUES (2, NULL, '13222222222', '010-61232222', '13123456789');
INSERT INTO emp_contact VALUES (3, NULL, NULL, NULL, '13123450000');
INSERT INTO emp_contact VALUES (4, NULL, NULL, '010-61234444', '13123457777');

现在需要找出每个员工的联系电话，规则是先找移动电话；如果没有，再找工作电话；如果没有，再找家庭电话；最后找紧急联系人电话。试试你可以写出几种查询方法？

-- 方法1：利用 COALESCE 函数处理空值
SELECT emp_id,
       COALESCE(mobile_phone, work_phone, home_phone, emergency_phone) AS phone
  FROM emp_contact;

-- 方法2：利用 CASE 表达式处理空值
SELECT emp_id,
       CASE
         WHEN mobile_phone IS NOT NULL THEN mobile_phone
         WHEN work_phone IS NOT NULL THEN work_phone
         WHEN home_phone IS NOT NULL THEN home_phone
         ELSE emergency_phone
       END  AS phone
  FROM emp_contact;

emp_id|phone       |
------|------------|
     1|010-61231111|
     2|13222222222 |
     3|13123450000 |
     4|010-61234444|
