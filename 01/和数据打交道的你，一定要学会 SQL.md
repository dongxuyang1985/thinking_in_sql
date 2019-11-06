## 和数据打交道的你，一定要学会 SQL

### 专栏背景

1970 年 IBM 的 E.F. Codd 博士发表了论文《A Relational Model of Data for Large Shared Data Banks》并创建了关系模型，通过一个简单的数据结构（关系，也就是二维表）来实现数据的存储。

1979 年 Relational Software, Inc.（后来改名为 Oracle）发布了第一个商用的关系数据库产品。随后出现了大量的关系数据库管理系统，包括 MySQL、SQL Server、PostgreSQL 以及大数据分析平台 Apache Hive、Spark SQL、Presto 等。至今，关系数据库仍然是数据库领域的主流。

以下是著名的数据库系统排名网站 [DB-Engines](https://db-engines.com/en/ranking) 上各种数据库的排名情况，关系数据库占据了绝对的优势。

![rank](https://img-blog.csdnimg.cn/20191018215508351.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

#### SQL

<font color="#F39800">SQL（Structured Query Language，结构化查询语言）是访问和操作关系数据库的标准语言。</font>只要是关系数据库，都可以使用 SQL 进行访问和控制。SQL 同样由 IBM 在 1970 年代开发，1986 年成为 ANSI 标准，并且在 1987 年成为 ISO 标准。SQL 标准随后经历了多次修订，最新的版本为 SQL:2019，增加了多维数组（MDA）的支持。下图是 SQL 标准的发展历程和主要的新增功能。
![sql_history](https://img-blog.csdnimg.cn/20190716221652471.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
对于 SQL 标准，人们最熟悉的就是 SQL92 或者 SQL99。但实际上经过多次修改，SQL 早已不是 40 年前的 SQL；如今它已经相当完备，功能强大，并且能够同时支持关系模型和非关系（XML、JSON）模型。具体来说，最新的 SQL 标准包含 10 个部分：

 - ISO/IEC 9075-1 信息技术 – 数据库语言 – SQL – 第1部分：框架（SQL/框架）
 - ISO/IEC 9075-2 信息技术 – 数据库语言 – SQL – 第2部分：基本原则（SQL/基本原则）
 - ISO/IEC 9075-3 信息技术 – 数据库语言 – SQL – 第3部分：调用级接口（SQL/CLI）
 - ISO/IEC 9075-4 信息技术 – 数据库语言 – SQL – 第4部分：持久存储模块（SQL/PSM）
 - ISO/IEC 9075-9 信息技术 – 数据库语言 – SQL – 第9部分：外部数据管理（SQL/MED）
 - ISO/IEC 9075-10 信息技术 – 数据库语言 – SQL – 第10部分：对象语言绑定（SQL/OLB）
 - ISO/IEC 9075-11 信息技术 – 数据库语言 – SQL – 第11部分：信息与定义概要（SQL/Schemata）
 - ISO/IEC 9075-13 信息技术 – 数据库语言 – SQL – 第13部分：使用 Java 编程语言的 SQL 程序与类型（SQL/JRT）
 - ISO/IEC 9075-14 信息技术 – 数据库语言 – SQL – 第14部分：XML 相关规范（SQL/XML）
 - ISO/IEC 9075-15 信息技术 – 数据库语言 – SQL – 第15部分：多维数组（SQL/MDA）

为了便于学习，通常将主要的 SQL 语句分为以下几个类别：
![sql](https://img-blog.csdnimg.cn/20190731191157470.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

 - **DQL**（data query language），**数据查询语言**；也就是 SELECT 语句，用于查询数据库中的数据和信息。
 - **DML**（data manipulation language），**数据操作语言**；用于对表中的数据进行增加（INSERT）、修改（UPDATE）、删除（DELETE）以及合并（MERGE）操作。
 - **DDL**（data definition language），**数据定义语言**；主要用于定义数据库中的对象（例如表或索引），包括创建对象（CREATE）、修改对象（ALTER）和删除对象（DROP）等。
 - **TCL**（transaction control language），**事务控制语言**；用于管理数据库的事务，主要包括启动一个事务（BEGIN TRANSACTION）、提交事务（COMMIT）、回退事务（ROLLBACK）和事务保存点（SAVEPOINT）。
 - **DCL**（data control language），**数据控制语言**；用于控制数据的访问权限，主要有授权（GRANT）和撤销（REVOKE）。

<font color="#F39800">SQL 是一种标准</font>，不同厂商基于 SQL 标准实现了自己的数据库产品，例如 Oracle、MySQL 等。这些数据库都在一定程度上兼容 SQL 标准，具有一定的可移植性。但另一方面，它们都存在许多专有的扩展，没有任何一种产品完全遵循标准。

#### NoSQL

随着互联网的发展和大数据的兴起，出现了各种各样的非关系（NoSQL）数据库。NoSQL 代表 **Not only SQL**，表明它是针对传统关系数据库的补充和升级，而不是为了替代关系数据库。

NoSQL 数据库主要用于解决关系数据库在某些特定场景下的局限性，比如海量存储和水平扩展；但同时也会为此牺牲某些关系数据库的特性，例如对事务强一致性的支持和标准 SQL 接口。因此，这类数据库主要用于对一致性要求不是非常严格的互联网业务。常见的 NoSQL 数据库可以分为以下几类：

 - 文档数据库，例如 [MongoDB](https://www.mongodb.com/)（MongoDB 4.0 增加了多文档事务的特性）；
 - 键值存储，例如 [Redis](https://redis.io/)；
 - 全文搜索引擎，例如 [Elasticsearch](https://www.elastic.co/products/elasticsearch)；
 - 宽列存储数据库，例如 [Cassandra](http://cassandra.apache.org/)；
 - 图形数据库，例如 [Neo4J](https://neo4j.com/)。

另一方面，关系数据库也在积极拥抱变化，添加了许多非关系模型（XML 和 JSON）支持。以最流行的开源关系数据库 MySQL 为例，最新的 MySQL 8.0 版本增加了 JSON 文档存储的支持，并且推出了一个新的概念：NoSQL + SQL = MySQL。以下是 MySQL 官方的宣传图。

![mysql](https://img-blog.csdnimg.cn/20190626105221675.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

Oracle、SQL Server 以及 PostgreSQL 同样也进行了类似的扩展，可以支持原生的 XML 和 JSON 数据，并且提供了许多标准的 SQL 接口。

#### NewSQL

中国有句古话：**天下大势，合久必分，分久必合**。数据库领域的发展也印证了这一规律，市场上已经出现了一类新型关系型数据库系统：NewSQL 数据库。这类数据库不仅保留了关系数据库对于事务的支持和标准的 SQL 接口，同时具有 NoSQL 的高度扩展性和高性能。

目前比较有代表性的 NewSQL 数据库包括 Google Spanner、VoltDB、PostgreSQL-XL 以及国产的 TiDB。这类新型数据库是数据库领域最新的发展方向，有志于在数据库行业发展的同学可以加以关注。

#### 为什么要学习 SQL？

让我们回到专栏的主题，为什么要学习 SQL 呢？简单来说，因为有用。下图是 Stack Overflow 在 2019 年关于最流行编程技术的调查结果。
![stack overflow](https://img-blog.csdnimg.cn/20190627200358674.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70#pic_center)
作为数据处理领域的专用语言，SQL 排在了第三位，超过 50% 的开发者都需要使用到 SQL。那么，具体什么职位需要使用 SQL，用 SQL 来做什么？

 - **数据分析师**：显然这是一群依靠分析数据为生的人，必不可少需要与数据库打交道，SQL 是他们必备技能之一。
 - **数据科学家**：与数据分析师一样，数据科学家的日常工作也离不开数据的处理，不可避免需要使用 SQL。
 - **数据库开发工程师**：这个职位基本就是写 SQL 代码，实现业务逻辑。
 - **数据库管理员**：也就是 DBA，主要职责是管理和维护数据库，除了会写 SQL，还需要负责审核开发人员编写的 SQL 代码。
 - **后端工程师**：后端开发必然需要涉及数据的处理，需要通过 SQL 与数据库进行交互。
 - **全栈工程师**：既然是全栈，自然包括后端数据的处理。
 - **移动开发工程师**：作为一名移动开发工程师，一定对 SQLite 数据库不会陌生，它是在移动设备中普遍存在的嵌入式数据库。
 - **产品经理**：产品经理需要了解产品的情况，而数据是最好的说明方式，了解 SQL 非常有利于对产品的把握。

SQL 不但应用广泛，而且简单易学。因为它在设计之初就考虑了非技术人员的使用需求，SQL 语句全都是由简单的英语单词组成，使用者只需要声明自己想要的结果，而将具体的实现过程交给数据库管理系统。

学习编程，你可能会犹豫选择 C++ 还是 Java；入门数据科学，你可能会纠结于选择 Python 还是 R；但无论如何，SQL 都是 IT 从业人员不可或缺的一项技能！

### 专栏内容
本专栏主要讨论 SQL 编程技术和思想，分为四个部分：基础篇、进阶篇、开发篇以及扩展篇。
![toc](https://img-blog.csdnimg.cn/20191023202914841.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

**第一部分：基础篇**。首先介绍数据库领域的最新发展，回顾数据库和 SQL 的核心概念；然后讨论如何使用 SELECT 语句查询数据，过滤数据，对结果进行排序，实现排行榜与分页效果；同时还会介绍常见的 SQL 函数，CASE 表达式以及数据的分组汇总；最后是一个分析世界银行全球 GDP 数据的实战案例。

**第二部分：进阶篇**。主要包括 SQL 数据分析的一些高级功能：空值的问题、多表连接查询、子查询、集合运算、通用表表达式与递归查询、高级分组与多维度交叉分析、窗口函数与高级报表以及基于行模式识别的数据流分析等。

**第三部分：开发篇**。讲述数据库设计与开发过程中涉及到的一些实用知识。包括如何设计规范化的数据库，管理数据库对象，对数据进行增删改，数据库事务的概念，索引的原理；同时还会介绍视图的概念，使用存储过程实现业务逻辑以及利用触发器实现用户操作的审计。

**第四部分：扩展篇**。分析 SQL 语句的执行计划与查询语句的优化，使用 SQL 处理 JSON 数据，在 Python 和 Java 中执行 SQL 语句，以及动态语句和 SQL 注入攻击的预防。在专栏的最后，探讨一下 SQL 编程中的道与术。

如果是初学者，建议按照顺序阅读；如果你已经具有一定的 SQL 基础，也可以针对感兴趣的部分单独学习。

### 专栏寄语
希望大家能够通过本专栏的学习，在掌握 SQL 技能的同时能够理解对面向集合的编程思想，并且在将来的工作中学以致用。

学习是一个输入再输出的过程，因此特地创建了本专栏的微信交流群，让我们一起学习一起成长。入群方式请扫描第 3 篇末尾的微信二维码，欢迎你来！
