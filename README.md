# Thinking In SQL

GitChat 达人课《SQL 编程思想》示例数据库，提供 Oracle、MySQL、SQL Server 以及 PostgreSQL 初始化脚本。

执行步骤如下：

 1. 运行 create_table.sql 创建示例表，所有数据库使用相同的脚本；
 2. 根据不同的数据库选择相应的 load_data_xxx.sql 生成初始化数据；
 3. 运行 drop_table.sql 清除示例表，然后可以再次创建示例表并初始化数据。
