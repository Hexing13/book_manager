package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by hexing on 15-6-11.
 */
@WebServlet(name = "renew",urlPatterns = {"/renewed"})
public class renewed extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bid = request.getParameter("renew");
        if(bid != null){
            BookConn conn = new BookConn();
            response.setContentType("text/html;charset=UTF-8");
            String sql = "select bdate from borrow where bid = "+bid+"";
            System.out.println(sql);
            ResultSet rs = conn.getRs(sql);
            try {
                if(rs.next()){
                    Date d = rs.getDate("bdate");
                    Date d1 = new Date(d.getTime() + 30 * 24 * 60 * 60 * 1000L);
                    SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                    System.out.println(f.format(d));
                    System.out.println(f.format(d1));
                    String sql1 = "update borrow set bdate = '"+f.format(d1)+"' where bid = "+bid+"";
                    String sql2 = "update borrow set flag = 1 where bid = "+bid+"";

                    System.out.println(sql1);
                    conn.Excu(sql1);
                    conn.Excu(sql2);
                    response.sendRedirect("renewed.jsp");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
