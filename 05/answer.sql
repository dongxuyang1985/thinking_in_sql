-- 第 5 篇思考题参考答案
-- 如果将本节中的邮箱验证模式改为 `^[a-z0-9]+[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{2,4}$`，也就是去掉了正则表达式中的大写字母 A-Z，
-- 如何确保仍然能够匹配大写形式的邮箱地址？

-- MySQL 实现。也可以不加 i 选项，因为这是默认值。
SELECT email
  FROM t_regexp
 WHERE REGEXP_LIKE(email, '^[a-z0-9]+[a-z0-9._-]+@[a-z0-9.-]+\\.[a-z]{2,4}$', 'i');

-- Oracle 实现
SELECT email
  FROM t_regexp
 WHERE REGEXP_LIKE(email, '^[a-z0-9]+[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{2,4}$', 'i');

-- PostgreSQL 实现
SELECT email
  FROM t_regexp
 WHERE email ~* '^[a-z0-9]+[a-z0-9._-]+@[a-z0-9.-]+\.[a-z]{2,4}$';

-- SQL Server 没有提供相应的正则表达式函数。
