package com.hx.book;

import java.sql.*;

/**
 * Created by hexing on 15-6-9.
 */
public class BookConn {
    Connection conn = null;
    Statement st = null;
    ResultSet rs = null;

    public void Init(){
        try {
            Class.forName("com.mysql.jdbc.Driver");//载入驱动
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/book_manager", "root", "hx106107");//建立连接
            st = (Statement) conn.createStatement();//发送连接语句
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void Excu(String sql){
        Init();
        try {
            st.execute(sql);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ResultSet getRs(String sql){
        Init();
        try {
            rs = st.executeQuery(sql);
            return rs;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}
