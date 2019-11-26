# 导入 MySQL Connector Python 模块和 Error 对象
import mysql.connector
from mysql.connector import Error
from configparser import ConfigParser

def read_db_config(filename='dbconfig.ini', section='mysql'):
    """ 读取数据库配置文件，返回一个字典对象
    """
    # 创建解析器，读取配置文件
    parser = ConfigParser()
    parser.read(filename)

    # 获取 mysql 部分的配置
    db = {}
    if parser.has_section(section):
        items = parser.items(section)
        for item in items:
            db[item[0]] = item[1]
    else:
        raise Exception('文件 {1} 中未找到 {0} 配置信息！'.format(section, filename))

    return db

db_config = read_db_config()
connection = None

try:
    # 使用 mysql.connector.connect 方法连接 MySQL 数据库
    connection = mysql.connector.connect(**db_config)

    sql_str = """DELETE FROM employee
                  WHERE emp_name = %s"""
    emp_info = ('李四',)
    cursor = connection.cursor(prepared=True)
    cursor.execute(sql_str, emp_info)
    connection.commit()

    cursor.execute("SELECT emp_name, salary, bonus, email FROM employee WHERE emp_name = '李四'")
    result = cursor.fetchone()

    # 打印查询结果
    if result is not None:
        print(result)
except Error as e:
    print("删除员工信息失败：", e)
finally:
    # 释放数据库连接
    if (connection.is_connected()):
        cursor.close()
        connection.close()
        print("MySQL 数据库连接已关闭。")
