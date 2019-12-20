package com.test;

// 导入 JDBC 和 IO 包
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class MySQLInsert {
    public static void main(String[] args )
    {
        String url = null;
        String user = null;
        String password = null;
        String sql_str = "INSERT INTO employee(emp_id, emp_name, sex, dept_id, manager, hire_date, job_id, salary, bonus, email) " +
                "SELECT MAX(emp_id)+1, ?, ?, ?, ?, ?, ?, ?, ?, ? FROM employee";

        ResultSet rs = null;

        // 读取数据库连接配置文件
        try (FileInputStream file = new FileInputStream("db.properties")) {

            Properties p = new Properties();
            p.load(file);
            url = p.getProperty("url");
            user = p.getProperty("user");
            password = p.getProperty("password");
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }

        // 建立数据库连接，创建查询语句，并且执行语句
        try (Connection conn = DriverManager.getConnection(url, user, password);
             PreparedStatement ps = conn.prepareStatement(sql_str)) {

            // 设置输入参数
            ps.setString(1, "张三");
            ps.setString(2, "男");
            ps.setInt(3, 5);
            ps.setInt(4, 18);
            ps.setDate(5, Date.valueOf("2019-12-12"));
            ps.setInt(6, 10);
            ps.setInt(7, 5000);
            ps.setInt(8, 600);
            ps.setString(9, "zhangsan@shuoguo.com");

            // 执行插入操作
            int rowCount = ps.executeUpdate();
            if(rowCount == 1)
            {
                System.out.println("新建员工成功。");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
