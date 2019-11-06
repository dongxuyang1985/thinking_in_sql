## 在 SQL 的世界里一切都是关系

在上一篇中，我们回顾了数据库领域以及 SQL 的最新发展趋势。

本篇我们将会介绍 SQL 的基本特性以及最重要的一个编程思想：一切都是关系。让我们先来回顾一下关系数据库的几个基本概念。

### 关系数据库
关系数据库（Relational database）是指基于关系模型的数据库。关系模型由关系数据结构、关系操作集合、关系完整性约束三部分组成。

#### 数据结构

**在关系模型中，用于存储数据的逻辑结构称为关系（Relation）；对于使用者而言，关系就是二维表（Table）**。

以下是一个员工信息表，它和 Excel 表格非常类似，由行（Row）和列（Column）组成。

![employee](https://img-blog.csdnimg.cn/20190516220054723.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2hvcnNlcw==,size_16,color_FFFFFF,t_70#pic_center)

在不同的场景下，大家可能会听到关于同一个概念的不同说法。在此，我们列出了关系数据库中的一些常见概念：

 - **关系**，也称为**表**，用于表示现实世界中的实体（Entity）或者实体之间的联系（Relationship）。举例来说，一个公司的员工、部门和职位都是实体，分别对应员工信息表、部门信息表和职位信息表；销售的产品和订单都是实体，同时它们之间存在联系，对应订单明细表。
 - **行**，也称为**记录**（Record），代表了关系中的单个实体。上图中工号为 4 的数据行存储了“诸葛亮”的相关信息。关系（表）可以看作是由行组成的集合。
 - **列**，也称为**字段**（Field），表示实体的某个属性。上图中的第二列包含了员工的姓名。表中的每个列都有一个对应的数据类型，常见的数据类型包括字符类型、数字类型、日期时间类型等。

有了关系结构之后，就需要定义基于关系的数据操作。

#### 操作集合

常见的数据操作包括**增加**（Create）、**查询**（Retrieve）、**更新**（Update）以及**删除**（Delete），或者统称为**增删改查**（CRUD）。

其中，使用最多、也最复杂的操作就是查询，具体来说包括**选择**（Selection）、**投影**（Projection）、**并集**（Union）、**交集**（Intersection）、**差集**（exception）以及**笛卡儿积**（Cartesian product）等。我们将会介绍如何使用 SQL 语句完成以上各种数据操作。

为了维护数据的完整性或者满足业务需求，关系模型还定义了完整性约束。
#### 完整性约束

关系模型中定义了三种完整性约束：**实体完整性**、**参照完整性**以及**用户定义完整性**。

 - **实体完整性**是指表的主键字段不能为空。现实中的每个实体都具有唯一性，比如每个人都有唯一的身份证号；在关系数据库中，这种唯一标识每一行数据的字段称为主键（Primary Key），主键字段不能为空。每个表可以有且只能有一个主键。
 - **参照完整性**是指外键参照的完整性。外键（Foreign Key）代表了两个表之间的关联关系，比如员工属于某个部门；因此员工表中存在部门编号字段，引用了部门表中的部门编号字段。对于外键引用，被引用的数据必须存在，员工不可能属于一个不存在的部门；删除某个部门之前，也需要对部门中的员工进行相应的处理。
 - **用户定义完整性**是指基于业务需要自定义的约束。非空约束（NOT NULL）确保了相应的字段不会出现空值，例如员工一定要有姓名；唯一约束（UNIQUE）用于确保字段中的值不会重复，每个员工的电子邮箱必须唯一；检查约束（CHECK）可以定义更多的业务规则。例如，薪水必须大于 0 ，字符必须大写等；默认值（DEFAULT）用于向字段中插入默认的数据。

本专栏涉及的 4 种数据库对于这些完整性约束的支持情况如下：

数据库 | 非空约束 | 唯一约束 | 主键约束 | 外键约束 | 检查约束 | 默认值 
--|--|--|--|--|--|--
**Oracle** | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 
**MySQL** | 支持 | 支持 | 支持 | <font color="orange">支持</font>* | 支持* | 支持 
**SQL Server** | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 
**PostgreSQL** | 支持 | 支持 | 支持 | 支持 | 支持 | 支持 

\* MySQL 中只有 InnoDB 存储引擎支持外键约束；MySQL 8.0.16 增加了对检查约束的支持。

> 存储引擎（Storage Engine）是 MySQL 中用于管理、访问和修改物理数据的组件，不同的存储引擎提供了不同的功能和特性。从 MySQL 5.5 开始默认使用 InnoDB 存储引擎，支持事务处理（ACID）、行级锁定、故障恢复、多版本并发控制（MVCC）以及外键约束等。

关系数据库使用 SQL 作为访问和操作数据的标准语言。现在，让我们来直观感受一下 SQL 语句的特点。

### SQL：一种面向集合的编程语言

> 本节会出现几个示例，我们还没有正式开始学习 SQL 语句，可以暂时不必理会细节。

#### 语法特性

<font color="#F39800">SQL 是一种声明性的编程语言，语法接近于自然语言（英语）。</font>通过几个简单的英文单词，例如 SELECT、INSERT、UPDATE、CREATE、DROP 等，完成大部分的数据库操作。以下是一个简单的查询示例：

```sql
SELECT emp_id, emp_name, salary
  FROM employee
 WHERE salary > 10000
 ORDER BY emp_id;
```

即使没有学过 SQL 语句，但只要知道几个单词的意思，就能明白该语句的作用。它查询员工表（employee）中月薪（salary）大于 10000 的员工，返回工号、姓名以及月薪，并且按照工号进行排序。可以看出，SQL 语句非常简单直观。

以上查询中的 SELECT、FROM 等称为关键字（也称为子句），一般大写；表名、列名等内容一般小写；分号（;）表示语句的结束。SQL 语句不区分大小写，但是遵循一定的规则可以让代码更容易阅读。

> SQL 是一种声明式的语言，声明式语言的主要思想是告诉计算机想要什么结果（what），但不指定具体怎么做。这类语言还包括 HTML、正则表达式以及函数式编程等。

#### 面向集合
<font color="#F39800">对于 SQL 语句而言，它所操作的对象是一个集合（表），操作的结果也是一个集合（表）。</font>例如以下查询：

```sql
SELECT emp_id, emp_name, salary
  FROM employee;
```

其中 employee 是一个表，它是该语句查询的对象；同时，查询的结果也是一个表。所以，我们可以继续扩展该查询：

```sql
SELECT emp_id, emp_name, salary
  FROM (
       SELECT emp_id, emp_name, salary
         FROM employee
       ) dt;
```

我们将括号中的查询结果（取名为 dt）作为输入值，传递给了外面的查询；最终整个语句的结果仍然是一个表。在第 17 篇中，我们将会介绍这种嵌套在其他语句中的查询就是子查询（Subquery）。

SQL 中的查询可以完成各种数据操作，例如过滤转换、分组汇总、排序显示等；但是它们本质上都是针对表的操作，结果也是表。

![query](https://img-blog.csdnimg.cn/2019071809080382.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)

不仅仅是查询语句，SQL 中的插入、更新和删除都以集合为操作对象。我们再看一个插入数据的示例：

```sql
CREATE TABLE t(id INTEGER);

-- 适用于 MySQL、SQL Server 以及 PostgreSQL
INSERT INTO t(id)
VALUES (1), (2), (3);
```

我们首先使用 CREATE TABLE 语句创建了一个表，然后使用 INSERT INTO 语句插入数据。在执行插入操作之前，会在内存中创建一个包含 3 条数据的临时集合（表），然后将该集合插入目标表中。由于我们通常一次插入一条数据，以为是按照数据行进行插入；实际上，一条数据也是一个集合，只不过它只有一个元素而已。

Oracle 不支持以上插入多行数据的语法，可以使用下面的插入语句：

```sql
-- 适用于 Oracle
INSERT INTO t(id)
SELECT 1 FROM DUAL
 UNION ALL
SELECT 2 FROM DUAL
 UNION ALL
SELECT 3 FROM DUAL;
```

UNION ALL 是 SQL 中的并集运算，用于将两个集合组成一个更大的集合。此外，SQL 还支持交集运算（INTERSECT）、差集运算（EXCEPT）以及笛卡儿积（Cartesian product）。我们会在第 18 篇中介绍这些内容，它们也都是以集合为对象的操作。

我们已经介绍了 SQL 语言的声明性和面向集合的编程思想。在正式学习编写 SQL 语句之前，还需要进行一些准备工作，主要就是安装示例数据库。

### 示例数据库
在本专栏的学习过程中，我们主要使用一个虚构的公司数据模型。该示例数据库包含 3 个表：员工表（employee）、部门表（department）和职位表（job）。以下是它们的结构图，也称为实体-关系图（Entity-Relational Diagram）：
![er](https://img-blog.csdnimg.cn/20190624140051863.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70#pic_center)
 - **部门表**（department），包含部门编号（dept_id）和部门名称（dept_name）字段，主键为部门编号。该表共计 6 条数据。
 - **职位表**（job），包含职位编号（job_id）和职位名称（job_title）字段，主键为职位编号。该表共计 10 条数据。
 - **员工表**（employee），包含员工编号（emp_id）和员工姓名（emp_name）等字段，主键为员工编号，部门编号（dept_id）字段是引用部门表的外键，职位编号（job_id）字段是引用职位表的外键，经理编号（manager）字段是引用员工表自身的外键。该表共计 25 条数据。

我们在 GitHub 上为大家提供了示例表和初始数据的创建脚本和安装说明，支持 Oracle、MySQL、SQL Server 以及 PostgreSQL。点击[链接](https://github.com/dongxuyang1985/thinking_in_sql)进行下载。

运行这些脚本之前，需要先安装数据库软件。网络上有很多这类安装教程可以参考；如果无法安装数据库，也可以使用这个免费的在线 SQL 开发环境：[http://sqlfiddle.com](http://sqlfiddle.com)，它提供了各种常见的关系数据库服务。下图是使用 MySQL 运行示例脚本的结果：
![sql fiddle](https://img-blog.csdnimg.cn/20190624161633377.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly90b255ZG9uZy5ibG9nLmNzZG4ubmV0,size_16,color_FFFFFF,t_70)
选择数据库之后，将创建表和插入数据的脚本复制到左边窗口，点击“Build Schema”进行初始化；点击“Browser”可以查看表结构；在右侧窗口输入 SQL 语句，点击“Run SQL”运行并查看结果。该工具提供的数据库不是最新版本，但是可以运行大部分的示例。

本专栏中所有的示例都在以下数据库版本中进行了验证：

 - Oracle database 18c
 - MySQL 8.0
 - SQL Server 2017
 - PostgreSQL 12

我们使用 [DBeaver](https://dbeaver.io/) 开发工具编写所有的 SQL 语句，该工具的安装和使用可以参考我的[博客文章](https://tonydong.blog.csdn.net/article/details/89683422)。当然，你也可以使用自己喜欢的开发工具。

### 小结
关系模型中定义了一个简单的数据结构，即关系（表），用于存储数据。SQL 是关系数据库的通用标准语言，它使用接近于自然语言（英语）的语法，通过声明的方式执行数据定义、数据操作、访问控制等。对于 SQL 而言，一切都是关系（表）。

### 参考文献

 - [美] Abraham Silberschatz，Henry F.Korth，S.Sudarshan 著，杨冬青，李红燕，唐世渭 译 ，《数据库系统概念（原书第6版）》，机械工业出版社，2012
