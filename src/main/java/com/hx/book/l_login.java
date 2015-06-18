package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet(name = "l_login", urlPatterns ={"/l_login"})
public class l_login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        response.setContentType("text/html;charset=UTF-8");
        //接受用户输入的信息
        String snum1 = request.getParameter("userid");
        String spassword = request.getParameter("password1");
        String sql = "select *from librbian where lname = '"+snum1+"'";
        ResultSet rs = conn.getRs(sql);
        try {
            if (rs.next()) {
                String lpassword = rs.getString("lpassword");
                String lname = rs.getString("lname");
                if(lpassword.equals(spassword)) {
                    request.setAttribute("name1", ""+lname+"");
                    request.getRequestDispatcher("l_logined.jsp").forward(request, response);
                }else {
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong>Warning!</strong>密码有误.\n" +
                            "</div>");
                    request.getRequestDispatcher("l_login.jsp").forward(request,response);
                }
            }else {
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong>Warning!</strong>请先注册.\n" +
                        "</div>");
                request.getRequestDispatcher("l_login.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();

        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
