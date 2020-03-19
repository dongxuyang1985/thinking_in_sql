# Thinking In SQL

GitChat 专栏[《SQL 从入门到精通》](https://gitbook.cn/gitchat/column/5dae96ec669f843a1a4aed95)的示例数据库，提供 Oracle、MySQL、SQL Server 以及 PostgreSQL 初始化脚本。

执行步骤如下：

 1. 运行 create_table.sql 创建示例表，所有数据库使用相同的脚本；
 2. 根据不同的数据库选择相应的 load_data_xxx.sql 生成初始化数据；
 3. 运行 drop_table.sql 删除示例表，然后可以再次创建示例表并初始化数据。

其他脚本按照课程章节进行组织，可以根据需要进行下载使用。
