-- 第 16 篇练习题参考答案
-- 假设公司规定每天早上九点上班，下午六点下班。上下班都需要打卡，打卡记录信息存储在 attendance 表中；同时日历信息存储在 calendar 表中。
-- 如何找出 2019 年 1 月份的员工缺勤记录？

-- calendar 和 employee 连接，获取每个员工应该打卡的日期；
-- 再和 attendance 左连接，获取每个员工九点之前上班打卡，下午六点之后下班打卡的记录；
-- 然后利用 WHERE 中找出缺失的打卡记录，就是员工的缺勤记录。
-- Oracle、MySQL 以及 PostgreSQL 实现
SELECT c.calendar_date,e.emp_name
  FROM calendar c
  JOIN employee e ON (c.is_work_day = 'Y')
  LEFT JOIN attendance a ON (a.emp_id = e.emp_id AND a.check_date = c.calendar_date
                             AND EXTRACT(hour FROM a.clock_in) < 9
                             AND EXTRACT(hour FROM a.clock_out) >= 18)
 WHERE a.emp_id IS NULL
 ORDER BY c.calendar_date;

-- SQL Server 实现
SELECT c.calendar_date,e.emp_name
  FROM calendar c
  JOIN employee e ON (c.is_work_day = 'Y')
  LEFT JOIN attendance a ON (a.emp_id = e.emp_id AND a.check_date = c.calendar_date
                             AND DATEPART(hour, a.clock_in) < 9
                             AND DATEPART(hour, a.clock_out) >= 18)
 WHERE a.emp_id IS NULL
 ORDER BY c.calendar_date;

calendar_date|emp_name|
-------------|--------|
   2019-01-02|简雍     |
   2019-01-08|关平     |
   2019-01-11|简雍     |
   2019-01-17|廖化     |
   2019-01-21|黄忠     |
   2019-01-28|法正     |
