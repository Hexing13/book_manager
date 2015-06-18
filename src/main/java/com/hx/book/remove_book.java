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
 * Created by hexing on 15-6-17.
 */
@WebServlet(name = "remove_book",urlPatterns = {"/remove_book"})
public class remove_book extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        int  bid = Integer.parseInt(request.getParameter("bid"));
        String sql = "select *from book where bid = '"+bid+"'";
        ResultSet rs = conn.getRs(sql);
        try {
            if(rs.next()){
                if(rs.getString("bcount").equals(rs.getString("bleftcount"))){
                    conn.Excu("delete from book where bid = '"+bid+"'");
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong></strong>删除成功. \n" +
                            "</div>");
                    request.getRequestDispatcher("remove_book.jsp").forward(request,response);
                }else {
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong></strong>还有图书未归还，请谨慎删除. \n" +
                            "</div>");
                    request.getRequestDispatcher("remove_book.jsp").forward(request,response);
                }
            }else {
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong></strong>没有此图书. \n" +
                        "</div>");
                request.getRequestDispatcher("remove_book.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
