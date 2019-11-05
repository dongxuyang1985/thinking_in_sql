-- 第 4 篇思考题参考答案
-- 查找 2018 年 1 月 1 日之后入职，月薪小于 5000，并且奖金小于 1000（包括没有奖金）的员工。

-- 只有 Oracle 需要执行以下 alter 语句
-- alter session set nls_date_format = 'YYYY-MM-DD';

SELECT *
  FROM employee
 WHERE hire_date > '2008-01-01'
   AND salary < 5000
   AND (bonus < 1000 OR bonus IS NULL);

emp_id|emp_name|sex|dept_id|manager|hire_date |job_id|salary |bonus|email               |
------|--------|---|-------|-------|----------|------|-------|-----|--------------------|
    21|黄权      |男  |      5|     18|2018-03-14|    10|4200.00|     |huangquan@shuguo.com|
    22|糜竺      |男  |      5|     18|2018-03-27|    10|4300.00|     |mizhu@shuguo.com    |
    23|邓芝      |男  |      5|     18|2018-11-11|    10|4000.00|     |dengzhi@shuguo.com  |
    24|简雍      |男  |      5|     18|2019-05-11|    10|4800.00|     |jianyong@shuguo.com |
    25|孙乾      |男  |      5|     18|2018-10-09|    10|4700.00|     |sunqian@shuguo.com  |
