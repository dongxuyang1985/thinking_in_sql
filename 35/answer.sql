-- 第 35 篇练习题参考答案
-- 练习题：假设存在以下用户表，使用两个 JSON 字段分别存储关注的人和粉丝：
-- MySQL
CREATE TABLE t_users(
  id             INT PRIMARY KEY,
  username       VARCHAR(50) NOT NULL,
  followed_users JSON, -- 关注的人
  followers      JSON -- 粉丝
);

-- Oracle
CREATE TABLE t_users(
  id             INT PRIMARY KEY,
  username       VARCHAR2(50) NOT NULL,
  followed_users VARCHAR2(4000) CHECK (followed_users IS JSON), -- 关注的人
  followers      VARCHAR2(4000) CHECK (followers IS JSON) -- 粉丝
);

-- SQL Server
CREATE TABLE t_users(
  id             INT PRIMARY KEY,
  username       VARCHAR(50) NOT NULL,
  followed_users VARCHAR(MAX) CHECK ( ISJSON(followed_users)>0 ), -- 关注的人
  followers      VARCHAR(MAX) CHECK ( ISJSON(followers)>0 ) -- 粉丝
);

-- PostgreSQL
CREATE TABLE t_users(
  id             INT PRIMARY KEY,
  username       VARCHAR(50) NOT NULL,
  followed_users JSONB, -- 关注的人
  followers      JSONB -- 粉丝
);

INSERT INTO t_users VALUES(1, '刘一', '[]', '[]');
INSERT INTO t_users VALUES(2, '陈二', '[]', '[]');
INSERT INTO t_users VALUES(3, '张三', '[]', '[]');
INSERT INTO t_users VALUES(4, '李四', '[]', '[]');
INSERT INTO t_users VALUES(5, '王五', '[]', '[]');

-- 问题 1：张三和李四分别关注了刘一，王五关注了张三，如何用 SQL 实现？
-- MySQL


-- Oracle

-- SQL Server

-- PostgreSQL

-- 问题 2：李四取消了对刘一的关注，如何用 SQL 实现？
-- MySQL
-- Oracle
-- SQL Server
-- PostgreSQL
