-- 第 9 篇思考题参考答案
-- 为了保护员工的隐私，在显示信息时将员工姓名进行隐藏处理：对于两个字的姓名，将姓氏显示为星号；
-- 对于三个字或更多字的姓名，将倒数第二个字显示为星号。如何使用 SQL 语句实现下面的效果？

-- Oracle 实现
-- 使用 * 替换姓名中的倒数第二个字符
SELECT emp_name,
       substr(emp_name, 1, length(emp_name)-2) || '*' || substr(emp_name, -1, 1)
FROM employee;

-- MySQL 实现
-- 使用 * 替换姓名中的倒数第二个字符
SELECT emp_name,
       insert(emp_name, char_length(emp_name)-1, 1,'*')
FROM employee;


-- SQL Server 实现
SELECT emp_name,
       concat(substring(emp_name, 1, len(emp_name)-2), '*', substring(emp_name, len(emp_name)-1, 1))
FROM employee;
 
-- PostgreSQL 实现
SELECT emp_name,
       concat(substring(emp_name, 1, length(emp_name)-2), '*', substring(emp_name, length(emp_name)-1, 1))
FROM employee;
                                                                      
emp_name|REPLACE(emp_name,SUBSTR(emp_name, -2, 1),'*')|
--------|---------------------------------------------|
刘备      |*备                                           |
关羽      |*羽                                           |
张飞      |*飞                                           |
诸葛亮     |诸*亮                                          |
黄忠      |*忠                                           |
魏延      |*延                                           |
孙尚香     |孙*香                                          |
孙丫鬟     |孙*鬟                                          |
...
