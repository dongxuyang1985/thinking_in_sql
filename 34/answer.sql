-- 第 34 篇思考题参考答案
-- 思考题 1：manager 字段上存在索引，以下查询是否会利用该索引查找数据：

SELECT *
  FROM employee e
 WHERE manager = '10';
 
-- 答案：可以利用索引。虽然 manager 字段是数字，查询条件中使用字符 10 进行查找；现在的数据库优化器可以自动处理这种情况，以下是各种数据库的执行计划：
 
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


-- 思考题 2：假如存在以下表 t，数据量很大。查询语句 1 和查询语句 2 哪个性能更好，还是差不多？
-- 语句 1
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
 GROUP BY col1;

-- 语句 2
EXPLAIN ANALYZE
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
   AND col3 = '10'
 GROUP BY col1;


-- 答案：第一个查询更快。因为它只需要通过扫描索引（Index-Only Scan）就可以得到结果，(col2, col1) 上有一个索引。
-- 第二个查询虽然可能返回的数据更少，但是需要通过索引访问表中的数据，也就是回表。

-- MySQL
EXPLAIN ANALYZE
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
 GROUP BY col1;
-> Group aggregate: count(0)  (actual time=0.072..0.074 rows=1 loops=1)
    -> Index lookup on test using idx_test (col2=1997)  (cost=0.35 rows=1) (actual time=0.044..0.053 rows=1 loops=1)

EXPLAIN ANALYZE
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
   AND col3 = '10'
 GROUP BY col1;
-> Group aggregate: count(0)  (actual time=0.112..0.112 rows=0 loops=1)
    -> Filter: (test.col3 = '10')  (cost=0.26 rows=0) (actual time=0.094..0.094 rows=0 loops=1)
        -> Index lookup on test using idx_test (col2=1997)  (cost=0.26 rows=1) (actual time=0.068..0.074 rows=1 loops=1)

-- Oracle
EXPLAIN PLAN FOR
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
 GROUP BY col1;
SELECT * FROM TABLE(dbms_xplan.display);
PLAN_TABLE_OUTPUT                                                                |
---------------------------------------------------------------------------------|
Plan hash value: 3226360314                                                      |
                                                                                 |
---------------------------------------------------------------------------------|
| Id  | Operation            | Name     | Rows  | Bytes | Cost (%CPU)| Time     ||
---------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT     |          |     1 |     8 |     2   (0)| 00:00:01 ||
|   1 |  SORT GROUP BY NOSORT|          |     1 |     8 |     2   (0)| 00:00:01 ||
|*  2 |   INDEX RANGE SCAN   | IDX_TEST |     1 |     8 |     2   (0)| 00:00:01 ||
---------------------------------------------------------------------------------|
                                                                                 |
Predicate Information (identified by operation id):                              |
---------------------------------------------------                              |
                                                                                 |
   2 - access("COL2"=1997)                                                       |



EXPLAIN PLAN FOR
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
   AND col3 = '10'
 GROUP BY col1;
SELECT * FROM TABLE(dbms_xplan.display);
PLAN_TABLE_OUTPUT                                                                        |
-----------------------------------------------------------------------------------------|
Plan hash value: 3376241739                                                              |
                                                                                         |
-----------------------------------------------------------------------------------------|
| Id  | Operation                    | Name     | Rows  | Bytes | Cost (%CPU)| Time     ||
-----------------------------------------------------------------------------------------|
|   0 | SELECT STATEMENT             |          |     1 |    13 |     3   (0)| 00:00:01 ||
|   1 |  SORT GROUP BY NOSORT        |          |     1 |    13 |     3   (0)| 00:00:01 ||
|*  2 |   TABLE ACCESS BY INDEX ROWID| TEST     |     1 |    13 |     3   (0)| 00:00:01 ||
|*  3 |    INDEX RANGE SCAN          | IDX_TEST |     1 |       |     2   (0)| 00:00:01 ||
-----------------------------------------------------------------------------------------|
                                                                                         |
Predicate Information (identified by operation id):                                      |
---------------------------------------------------                                      |
                                                                                         |
   2 - filter("COL3"='10')                                                               |
   3 - access("COL2"=1997)                                                               |


-- SQL Server
SET STATISTICS PROFILE ON
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
 GROUP BY col1;
SET STATISTICS PROFILE OFF
Rows|Executes|StmtText                                                                                                                    |StmtId|NodeId|Parent|PhysicalOp      |LogicalOp     |Argument                                                                                         |DefinedValues                                |EstimateRows|EstimateIO|EstimateCPU|AvgRowSize|TotalSubtreeCost|OutputList                            |Warnings|Type    |Parallel|EstimateExecutions|
----|--------|----------------------------------------------------------------------------------------------------------------------------|------|------|------|----------------|--------------|-------------------------------------------------------------------------------------------------|---------------------------------------------|------------|----------|-----------|----------|----------------|--------------------------------------|--------|--------|--------|------------------|
   1|       1|SELECT col1, count(*)¶  FROM test¶ WHERE col2 = 1997¶ GROUP BY col1                                                         |     1|     1|     0|                |              |                                                                                                 |                                             |           1|          |           |          |       0.0032842|                                      |        |SELECT  |       0|                  |
   0|       0|  |--Compute Scalar(DEFINE:([Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0)))                                                 |     1|     2|     1|Compute Scalar  |Compute Scalar|DEFINE:([Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0))                                           |[Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0)|           1|         0|          0|        15|       0.0032842|[hrdb].[dbo].[test].[col1], [Expr1002]|        |PLAN_ROW|       0|                 1|
   1|       1|       |--Stream Aggregate(GROUP BY:([hrdb].[dbo].[test].[col1]) DEFINE:([Expr1005]=Count(*)))                              |     1|     3|     2|Stream Aggregate|Aggregate     |GROUP BY:([hrdb].[dbo].[test].[col1])                                                            |[Expr1005]=Count(*)                          |           1|         0|          0|        15|       0.0032842|[hrdb].[dbo].[test].[col1], [Expr1005]|        |PLAN_ROW|       0|                 1|
   1|       1|            |--Index Seek(OBJECT:([hrdb].[dbo].[test].[idx_test]), SEEK:([hrdb].[dbo].[test].[col2]=(1997)) ORDERED FORWARD)|     1|     4|     3|Index Seek      |Index Seek    |OBJECT:([hrdb].[dbo].[test].[idx_test]), SEEK:([hrdb].[dbo].[test].[col2]=(1997)) ORDERED FORWARD|[hrdb].[dbo].[test].[col1]                   |           1|  0.003125|   1.581E-4|        11|       0.0032831|[hrdb].[dbo].[test].[col1]            |        |PLAN_ROW|       0|                 1|

SET STATISTICS PROFILE ON
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
   AND col3 = '10'
 GROUP BY col1;
SET STATISTICS PROFILE OFF
Rows|Executes|StmtText                                                                                                                                                                                                                      |StmtId|NodeId|Parent|PhysicalOp          |LogicalOp           |Argument                                                                                                                                                                            |DefinedValues                                       |EstimateRows|EstimateIO|EstimateCPU|AvgRowSize|TotalSubtreeCost|OutputList                                          |Warnings|Type    |Parallel|EstimateExecutions|
----|--------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------|------|------|--------------------|--------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------|------------|----------|-----------|----------|----------------|----------------------------------------------------|--------|--------|--------|------------------|
   0|       1|SELECT col1, count(*)¶  FROM test¶ WHERE col2 = 1997¶   AND col3 = '10'¶ GROUP BY col1                                                                                                                                        |     1|     1|     0|                    |                    |                                                                                                                                                                                    |                                                    |           1|          |           |          |      0.00657196|                                                    |        |SELECT  |       0|                  |
   0|       0|  |--Compute Scalar(DEFINE:([Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0)))                                                                                                                                                   |     1|     2|     1|Compute Scalar      |Compute Scalar      |DEFINE:([Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0))                                                                                                                              |[Expr1002]=CONVERT_IMPLICIT(int,[Expr1005],0)       |           1|         0|          0|        15|      0.00657196|[hrdb].[dbo].[test].[col1], [Expr1002]              |        |PLAN_ROW|       0|                 1|
   0|       1|       |--Stream Aggregate(GROUP BY:([hrdb].[dbo].[test].[col1]) DEFINE:([Expr1005]=Count(*)))                                                                                                                                |     1|     3|     2|Stream Aggregate    |Aggregate           |GROUP BY:([hrdb].[dbo].[test].[col1])                                                                                                                                               |[Expr1005]=Count(*)                                 |           1|         0|          0|        15|      0.00657196|[hrdb].[dbo].[test].[col1], [Expr1005]              |        |PLAN_ROW|       0|                 1|
   0|       1|            |--Nested Loops(Inner Join, OUTER REFERENCES:([hrdb].[dbo].[test].[id]))                                                                                                                                          |     1|     4|     3|Nested Loops        |Inner Join          |OUTER REFERENCES:([hrdb].[dbo].[test].[id])                                                                                                                                         |                                                    |           1|         0|          0|        18|      0.00657038|[hrdb].[dbo].[test].[col1]                          |        |PLAN_ROW|       0|                 1|
   1|       1|                 |--Index Seek(OBJECT:([hrdb].[dbo].[test].[idx_test]), SEEK:([hrdb].[dbo].[test].[col2]=(1997)) ORDERED FORWARD)                                                                                             |     1|     5|     4|Index Seek          |Index Seek          |OBJECT:([hrdb].[dbo].[test].[idx_test]), SEEK:([hrdb].[dbo].[test].[col2]=(1997)) ORDERED FORWARD                                                                                   |[hrdb].[dbo].[test].[id], [hrdb].[dbo].[test].[col1]|           1|  0.003125|   1.581E-4|        15|       0.0032831|[hrdb].[dbo].[test].[id], [hrdb].[dbo].[test].[col1]|        |PLAN_ROW|       0|                 1|
   0|       1|                 |--Clustered Index Seek(OBJECT:([hrdb].[dbo].[test].[PK__test__3213E83F926FBA4D]), SEEK:([hrdb].[dbo].[test].[id]=[hrdb].[dbo].[test].[id]),  WHERE:([hrdb].[dbo].[test].[col3]='10') LOOKUP ORDERED FORWARD)|     1|     7|     4|Clustered Index Seek|Clustered Index Seek|OBJECT:([hrdb].[dbo].[test].[PK__test__3213E83F926FBA4D]), SEEK:([hrdb].[dbo].[test].[id]=[hrdb].[dbo].[test].[id]),  WHERE:([hrdb].[dbo].[test].[col3]='10') LOOKUP ORDERED FORWARD|                                                    |           1|  0.003125|   1.581E-4|        61|       0.0032831|                                                    |        |PLAN_ROW|       0|                 1|


-- PostgreSQL
EXPLAIN ANALYZE
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
 GROUP BY col1;
QUERY PLAN                                                                                                              |
------------------------------------------------------------------------------------------------------------------------|
GroupAggregate  (cost=0.28..8.31 rows=1 width=12) (actual time=0.053..0.054 rows=1 loops=1)                             |
  Group Key: col1                                                                                                       |
  ->  Index Only Scan using idx_test on test  (cost=0.28..8.29 rows=1 width=4) (actual time=0.035..0.038 rows=1 loops=1)|
        Index Cond: (col2 = 1997)                                                                                       |
        Heap Fetches: 1                                                                                                 |
Planning Time: 0.475 ms                                                                                                 |
Execution Time: 0.135 ms                                                                                                |

EXPLAIN ANALYZE
SELECT col1, count(*)
  FROM test
 WHERE col2 = 1997
   AND col3 = '10'
 GROUP BY col1;
QUERY PLAN                                                                                                         |
-------------------------------------------------------------------------------------------------------------------|
GroupAggregate  (cost=0.28..8.31 rows=1 width=12) (actual time=0.125..0.126 rows=0 loops=1)                        |
  Group Key: col1                                                                                                  |
  ->  Index Scan using idx_test on test  (cost=0.28..8.29 rows=1 width=4) (actual time=0.122..0.123 rows=0 loops=1)|
        Index Cond: (col2 = 1997)                                                                                  |
        Filter: ((col3)::text = '10'::text)                                                                        |
        Rows Removed by Filter: 1                                                                                  |
Planning Time: 0.318 ms                                                                                            |
Execution Time: 0.208 ms                                                                                           |
