-- 第 34 篇思考题参考答案
-- 思考题 1：manager 字段上存在索引，以下查询是否会利用该索引查找数据：

SELECT *
  FROM employee e
 WHERE manager = '10';
 
-- 可以利用索引。虽然 manager 字段是数字，查询条件中使用字符 10 进行查找；现在的数据库优化器可以自动处理这种情况，以下是各种数据库的执行计划：
 
-- MySQL
EXPLAIN
SELECT *
  FROM employee e
 WHERE manager = '10';
id|select_type|table|partitions|type|possible_keys  |key            |key_len|ref  |rows|filtered|Extra|
--|-----------|-----|----------|----|---------------|---------------|-------|-----|----|--------|-----|
 1|SIMPLE     |e    |          |ref |idx_emp_manager|idx_emp_manager|5      |const|   1|     100|     |

-- Oracle
EXPLAIN PLAN FOR
SELECT *
  FROM employee e
 WHERE manager = '10';

SELECT * FROM TABLE(dbms_xplan.display);
PLAN_TABLE_OUTPUT                                                                                      |
-------------------------------------------------------------------------------------------------------|
Plan hash value: 3813740982                                                                            |
                                                                                                       |
-------------------------------------------------------------------------------------------------------|
| Id  | Operation                           | Name            | Rows  | Bytes | Cost (%CPU)| Time     ||
-------------------------------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT                    |                 |     1 |    56 |     2   (0)| 00:00:01 ||
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEE        |     1 |    56 |     2   (0)| 00:00:01 ||
|*  2 |   INDEX RANGE SCAN                  | IDX_EMP_MANAGER |     1 |       |     1   (0)| 00:00:01 ||
-------------------------------------------------------------------------------------------------------|
                                                                                                       |
Predicate Information (identified by operation id):                                                    |
---------------------------------------------------                                                    |
                                                                                                       |
   2 - access("MANAGER"=10)                                                                            |

-- SQL Server
SET STATISTICS PROFILE ON

SELECT *
  FROM employee e
 WHERE manager = 1;

SET STATISTICS PROFILE OFF
Rows|Executes|StmtText                                                                                                                                                           |StmtId|NodeId|Parent|PhysicalOp          |LogicalOp           |Argument                                                                                                                                |DefinedValues                                                                                                                               |EstimateRows|EstimateIO|EstimateCPU|AvgRowSize|TotalSubtreeCost|OutputList                                                                                                                                  |Warnings|Type    |Parallel|EstimateExecutions|
----|--------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|------|------|--------------------|--------------------|----------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|------------|----------|-----------|----------|----------------|--------------------------------------------------------------------------------------------------------------------------------------------|--------|--------|--------|------------------|
   5|       1|SELECT * FROM [employee] [e] WHERE [manager]=@1                                                                                                                    |     1|     1|     0|                    |                    |                                                                                                                                        |                                                                                                                                            |           5|          |           |          |       0.0033095|                                                                                                                                            |        |SELECT  |       0|                  |
   5|       1|  |--Clustered Index Scan(OBJECT:([hrdb].[dbo].[employee].[PK__employee__1299A8619C254354] AS [e]), WHERE:([hrdb].[dbo].[employee].[manager] as [e].[manager]=(1)))|     1|     2|     1|Clustered Index Scan|Clustered Index Scan|OBJECT:([hrdb].[dbo].[employee].[PK__employee__1299A8619C254354] AS [e]), WHERE:([hrdb].[dbo].[employee].[manager] as [e].[manager]=(1))|[e].[emp_id], [e].[emp_name], [e].[sex], [e].[dept_id], [e].[manager], [e].[hire_date], [e].[job_id], [e].[salary], [e].[bonus], [e].[email]|           5|  0.003125|   1.845E-4|       125|       0.0033095|[e].[emp_id], [e].[emp_name], [e].[sex], [e].[dept_id], [e].[manager], [e].[hire_date], [e].[job_id], [e].[salary], [e].[bonus], [e].[email]|        |PLAN_ROW|       0|                 1|

-- PostgreSQL
EXPLAIN 
SELECT *
  FROM employee e
 WHERE manager = 1;
QUERY PLAN                                                                        |
----------------------------------------------------------------------------------|
Index Scan using idx_emp_manager on employee e  (cost=0.14..8.16 rows=1 width=422)|
  Index Cond: (manager = 1)                                                       |
