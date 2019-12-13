package com.test;

// 导入 JDBC 和 IO 包
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.*;
import java.util.Properties;

public class MySQLDelete {
    public static <conn> void main(String[] args )
    {
        String url = null;
        String user = null;
        String password = null;
        String sql_str = "DELETE FROM employee WHERE emp_name = ?";

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

            // 执行插入操作
            int rowCount = ps.executeUpdate();
            if(rowCount == 1)
            {
                System.out.println("删除员工成功。");
            }
            else
            {
                System.out.println(String.format("员工不存在，姓名：%s。", "张三"));
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
