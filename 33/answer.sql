-- 第 33 篇练习题参考答案
- 练习题：查看并解读以下查询语句的执行计划：
SELECT d.dept_name AS "部门名称",
       (SELECT AVG(salary) AS avg_salary
          FROM employee
         WHERE dept_id = d.dept_id) AS "平均月薪"
  FROM department d
 ORDER BY d.dept_id;
 
 -- Oracle 查看执行计划
EXPLAIN PLAN FOR
SELECT d.dept_name AS "部门名称",
       (SELECT AVG(salary) AS avg_salary
          FROM employee
         WHERE dept_id = d.dept_id) AS "平均月薪"
  FROM department d
 ORDER BY d.dept_id;

SELECT * FROM TABLE(dbms_xplan.display);
PLAN_TABLE_OUTPUT                                                                                       |
--------------------------------------------------------------------------------------------------------|
Plan hash value: 3467934568                                                                             |
                                                                                                        |
--------------------------------------------------------------------------------------------------------|
| Id  | Operation                               | Name         | Rows  | Bytes | Cost (%CPU)| Time     ||
--------------------------------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT                        |              |     6 |   186 |     5  (20)| 00:00:01 ||
|   1 |  MERGE JOIN OUTER                       |              |     6 |   186 |     5  (20)| 00:00:01 ||
|   2 |   TABLE ACCESS BY INDEX ROWID           | DEPARTMENT   |     6 |    90 |     2   (0)| 00:00:01 ||
|   3 |    INDEX FULL SCAN                      | SYS_C007404  |     6 |       |     1   (0)| 00:00:01 ||
|*  4 |   SORT JOIN                             |              |     5 |    80 |     3  (34)| 00:00:01 ||
|   5 |    VIEW                                 | VW_SSQ_1     |     5 |    80 |     2   (0)| 00:00:01 ||
|   6 |     HASH GROUP BY                       |              |     5 |    35 |     2   (0)| 00:00:01 ||
|   7 |      TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEE     |    25 |   175 |     2   (0)| 00:00:01 ||
|   8 |       INDEX FULL SCAN                   | IDX_EMP_DEPT |    25 |       |     1   (0)| 00:00:01 ||
--------------------------------------------------------------------------------------------------------|
                                                                                                        |
Predicate Information (identified by operation id):                                                     |
---------------------------------------------------                                                     |
                                                                                                        |
   4 - access("ITEM_1"(+)="D"."DEPT_ID")                                                                |
       filter("ITEM_1"(+)="D"."DEPT_ID")                                                                |

-- 解读：
-- 1. Oracle 中的 ID 是一个序号，但不是执行的顺序。执行的先后根据缩进来判断，缩进最大的最先执行，缩进相同的从上至下执行；
-- 2. Oracle 通过排序合并连接（Sort Merge Join）实现以上查询，包括排序操作（SORT JOIN）和合并操作（MERGE JOIN）。
--    首先，DEPARTMENT 表通过主键扫描（INDEX FULL SCAN）获取 6 条记录，扫描结果已经按照主键排序；
--    其次，EMPLOYEE 表通过索引（IDX_EMP_DEPT）查找获取 25 条记录，然后通过哈希运算进行分组聚合（HASH GROUP BY），获得一个结果视图（VW_SSQ_1）；
--    最后，利用这两个排序的结果集进行合并操作，获得最终的查询结果。

-- MySQL 查看执行计划
EXPLAIN SELECT d.dept_name AS "部门名称",
       (SELECT AVG(salary) AS avg_salary
          FROM employee
         WHERE dept_id = d.dept_id) AS "平均月薪"
  FROM department d
 ORDER BY d.dept_id;
id|select_type       |table   |partitions|type |possible_keys|key         |key_len|ref           |rows|filtered|Extra|
--|------------------|--------|----------|-----|-------------|------------|-------|--------------|----|--------|-----|
 1|PRIMARY           |d       |          |index|             |PRIMARY     |4      |              |   6|     100|     |
 2|DEPENDENT SUBQUERY|employee|          |ref  |idx_emp_dept |idx_emp_dept|4      |hrdb.d.dept_id|   5|     100|     |

-- 解读：
-- 1. MySQL 执行计划包含 2 个查询部分，id 为 2 的关联子查询（DEPENDENT SUBQUERY）和 id 为 1 的外查询（PRIMARY）。
-- 2. 首先，department 表通过主键扫描（type 列为 index） 6 条记录，扫描结果已经按照主键排序；
--    其次，针对外查询中的每一行进行遍历，关联子查询中的 employee 表通过索引（type 列为 ref）进行查找并聚合出 5 条记录。
--    这种方式被称为嵌套循环连接（Nested Loops Join）。

-- SQL Server 查看执行计划
SET STATISTICS PROFILE ON

SELECT d.dept_name AS "部门名称",
       (SELECT AVG(salary) AS avg_salary
          FROM employee
         WHERE dept_id = d.dept_id) AS "平均月薪"
  FROM department d
 ORDER BY d.dept_id;

SET STATISTICS PROFILE OFF

Rows|Executes|StmtText                                                                                                                                                                                                        |StmtId|NodeId|Parent|PhysicalOp          |LogicalOp           |Argument                                                                                                                                                         |DefinedValues                                                                                                 |EstimateRows|EstimateIO|EstimateCPU|AvgRowSize|TotalSubtreeCost|OutputList                                |Warnings|Type    |Parallel|EstimateExecutions|
----|--------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|------|------|--------------------|--------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|------------|----------|-----------|----------|----------------|------------------------------------------|--------|--------|--------|------------------|
   6|       1|SELECT d.dept_name AS "部门名称",¶       (SELECT AVG(salary) AS avg_salary¶          FROM employee¶         WHERE dept_id = d.dept_id) AS "平均月薪"¶  FROM department d¶ ORDER BY d.dept_id                            |     1|     1|     0|                    |                    |                                                                                                                                                                 |                                                                                                              |           6|          |           |          |      0.00724678|                                          |        |SELECT  |       0|                  |
   0|       0|  |--Compute Scalar(DEFINE:([Expr1005]=[Expr1003]))                                                                                                                                                             |     1|     2|     1|Compute Scalar      |Compute Scalar      |DEFINE:([Expr1005]=[Expr1003])                                                                                                                                   |[Expr1005]=[Expr1003]                                                                                         |           6|         0|          0|        57|      0.00724678|[d].[dept_id], [d].[dept_name], [Expr1005]|        |PLAN_ROW|       0|                 1|
   6|       1|       |--Nested Loops(Left Outer Join, OUTER REFERENCES:([d].[dept_id]))                                                                                                                                       |     1|     3|     2|Nested Loops        |Left Outer Join     |OUTER REFERENCES:([d].[dept_id])                                                                                                                                 |                                                                                                              |           6|         0|          0|        57|      0.00724618|[d].[dept_id], [d].[dept_name], [Expr1003]|        |PLAN_ROW|       0|                 1|
   6|       1|            |--Clustered Index Scan(OBJECT:([hrdb].[dbo].[department].[PK__departme__DCA6597486F7BB6E] AS [d]), ORDERED FORWARD)                                                                                |     1|     4|     3|Clustered Index Scan|Clustered Index Scan|OBJECT:([hrdb].[dbo].[department].[PK__departme__DCA6597486F7BB6E] AS [d]), ORDERED FORWARD                                                                      |[d].[dept_id], [d].[dept_name]                                                                                |           6|  0.003125|   1.636E-4|        40|       0.0032886|[d].[dept_id], [d].[dept_name]            |        |PLAN_ROW|       0|                 1|
   0|       0|            |--Compute Scalar(DEFINE:([Expr1003]=CASE WHEN [Expr1010]=(0) THEN NULL ELSE [Expr1011]/CONVERT_IMPLICIT(numeric(19,0),[Expr1010],0) END))                                                          |     1|     5|     3|Compute Scalar      |Compute Scalar      |DEFINE:([Expr1003]=CASE WHEN [Expr1010]=(0) THEN NULL ELSE [Expr1011]/CONVERT_IMPLICIT(numeric(19,0),[Expr1010],0) END)                                          |[Expr1003]=CASE WHEN [Expr1010]=(0) THEN NULL ELSE [Expr1011]/CONVERT_IMPLICIT(numeric(19,0),[Expr1010],0) END|           1|         0|          0|        24|       0.0039325|[Expr1003]                                |        |PLAN_ROW|       0|                 6|
   5|       6|                 |--Stream Aggregate(DEFINE:([Expr1010]=Count(*), [Expr1011]=SUM([hrdb].[dbo].[employee].[salary])))                                                                                            |     1|     6|     5|Stream Aggregate    |Aggregate           |                                                                                                                                                                 |[Expr1010]=Count(*), [Expr1011]=SUM([hrdb].[dbo].[employee].[salary])                                         |           1|         0|          0|        24|       0.0039325|[Expr1010], [Expr1011]                    |        |PLAN_ROW|       0|                 6|
  25|       6|                      |--Clustered Index Scan(OBJECT:([hrdb].[dbo].[employee].[PK__employee__1299A8619C254354]), WHERE:([hrdb].[dbo].[employee].[dept_id]=[hrdb].[dbo].[department].[dept_id] as [d].[dept_id]))|     1|     7|     6|Clustered Index Scan|Clustered Index Scan|OBJECT:([hrdb].[dbo].[employee].[PK__employee__1299A8619C254354]), WHERE:([hrdb].[dbo].[employee].[dept_id]=[hrdb].[dbo].[department].[dept_id] as [d].[dept_id])|[hrdb].[dbo].[employee].[salary]                                                                              |           5| 0.0032035|    1.06E-4|        16|       0.0038395|[hrdb].[dbo].[employee].[salary]          |        |PLAN_ROW|       0|                 6|
 
 -- 解读：
 -- 1. SQL Server 和 MySQL 类似，采用了嵌套循环连接（Nested Loops Join），同时输出了更加详细的信息。
 -- 2. 首先，通过聚集索引扫描（Clustered Index Scan）获取 department 表中的 dept_id 和 dept_name，执行一次扫描返回 6 条记录；
 --    然后，通过聚集索引扫描（Clustered Index Scan）获取 employee 表中的 dept_id，同时进行聚合操作计算平均月薪，执行 6 次扫描返回 5 个聚合结果。
 
 -- PostgreSQL 查看执行计划
EXPLAIN ANALYZE SELECT d.dept_name AS "部门名称",
       (SELECT AVG(salary) AS avg_salary
          FROM employee
         WHERE dept_id = d.dept_id) AS "平均月薪"
  FROM department d
 ORDER BY d.dept_id;
QUERY PLAN                                                                                                                                |
------------------------------------------------------------------------------------------------------------------------------------------|
Sort  (cost=50.20..50.22 rows=6 width=48) (actual time=0.186..0.187 rows=6 loops=1)                                                       |
  Sort Key: d.dept_id                                                                                                                     |
  Sort Method: quicksort  Memory: 25kB                                                                                                    |
  ->  Seq Scan on department d  (cost=0.00..50.12 rows=6 width=48) (actual time=0.047..0.152 rows=6 loops=1)                              |
        SubPlan 1                                                                                                                         |
          ->  Aggregate  (cost=8.17..8.18 rows=1 width=32) (actual time=0.020..0.020 rows=1 loops=6)                                      |
                ->  Index Scan using idx_emp_dept on employee  (cost=0.14..8.16 rows=1 width=14) (actual time=0.007..0.010 rows=4 loops=6)|
                      Index Cond: (dept_id = d.dept_id)                                                                                   |
Planning Time: 0.418 ms                                                                                                                   |
Execution Time: 0.268 ms                                                                                                                  |
-- 解读：
-- 1. 通过 EXPLAIN ANALYZE 执行该语句并显示更多的信息。其他数据库也支持一些扩展的命令。
-- 2. 首先，使用全表扫描（Seq Scan）获取 department 表中的数据，执行一次循环扫描返回 6 条记录；
--    其次，执行子查询，通过索引扫描（Index Scan）获取 employee 表中的数据，同时进行聚合操作计算平均月薪，执行 6 次循环扫描平均获取 4 行数据。
--    PostgreSQL 实际上采用的也是嵌套循环连接（Nested Loops Join），最后在内存中通过 dept_id 进行快速排序。
