-- 第 28 篇思考题参考答案
-- 在上文隔离级别的示例中，将 MySQL 会话 1 的隔离级别设置为读已提交，或者在其他数据库中使用默认隔离级别；结果有什么不同？

-- 会话 1 设置隔离级别为 READ COMMITTED
mysql> SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
Query OK, 0 rows affected (0.00 sec)

mysql> BEGIN;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT *
    ->   FROM bank_card
    ->  WHERE user_name = 'A';
+----------+-----------+-----------+
| card_id  | user_name | balance   |
+----------+-----------+-----------+
| 62220801 | A         | 1200.0000 |
+----------+-----------+-----------+
1 row in set (0.02 sec)

-- 会话 2，修改账户 A 的余额但不提交
mysql> BEGIN;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE bank_card
    ->    SET balance = balance  + 100
    ->  WHERE user_name = 'A';
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> 
mysql> SELECT *
    ->   FROM bank_card
    ->  WHERE user_name = 'A';
+----------+-----------+-----------+
| card_id  | user_name | balance   |
+----------+-----------+-----------+
| 62220801 | A         | 1300.0000 |
+----------+-----------+-----------+
1 row in set (0.00 sec)

-- 回到会话 1，看不到会话 2 的修改
mysql> SELECT *
    ->   FROM bank_card
    ->  WHERE user_name = 'A';
+----------+-----------+-----------+
| card_id  | user_name | balance   |
+----------+-----------+-----------+
| 62220801 | A         | 1200.0000 |
+----------+-----------+-----------+
1 row in set (0.00 sec)

-- 回到会话 2，提交修改
mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

-- 再次回到会话 1，可以看到会话 2 已提交的修改
-- 也就是读已提交的效果
mysql> SELECT *
    ->   FROM bank_card
    ->  WHERE user_name = 'A';
+----------+-----------+-----------+
| card_id  | user_name | balance   |
+----------+-----------+-----------+
| 62220801 | A         | 1300.0000 |
+----------+-----------+-----------+
1 row in set (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)
