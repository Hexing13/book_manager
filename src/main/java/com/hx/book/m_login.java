package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hexing on 15-6-16.
 */
@WebServlet(name = "m_login",urlPatterns = {"/m_login"})
public class m_login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        response.setContentType("text/html;charset=UTF-8");
        //接受用户输入的信息
        String snum1 = request.getParameter("userid");
        String spassword = request.getParameter("password1");
        String sql = "select *from manager where mname = '"+snum1+"'";
        ResultSet rs = conn.getRs(sql);
        try {
            if (rs.next()) {
                String mpassword = rs.getString("mpassword");
                if(mpassword.equals(spassword)) {
                    System.out.println("1");
                    request.setAttribute("name2", ""+snum1+"");
                    request.getRequestDispatcher("m_logined.jsp").forward(request, response);
                }else {
                    System.out.println("2");
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong>Warning!</strong>密码有误.\n" +
                            "</div>");
                    request.getRequestDispatcher("m_login.jsp").forward(request,response);
                }
            }else {
                System.out.println("3");
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong>Warning!</strong>请先注册.\n" +
                        "</div>");
                request.getRequestDispatcher("m_login.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
