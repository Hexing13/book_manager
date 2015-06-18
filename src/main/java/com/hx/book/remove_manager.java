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
@WebServlet(name = "remove_manager",urlPatterns = {"/remove_manager"})
public class remove_manager extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        String snum1 = request.getParameter("userid");
        String sql = "select *from manager where mname = '"+snum1+"'";
        ResultSet rs = conn.getRs(sql);
        try {
            if(rs.next()){
                conn.Excu("delete from manager where mname = '"+snum1+"'");
                response.sendRedirect("m_logined.jsp");
            }else {
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong>Warning!</strong>不存在该管理员. \n" +
                        "</div>");
                request.getRequestDispatcher("remove_manager.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
