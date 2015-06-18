package com.hx.book;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by hexing on 15-6-17.
 */
@WebServlet(name = "add_book",urlPatterns = {"/add_book"})
public class add_book extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        String bid = request.getParameter("bid");
        String bname = request.getParameter("bname");
        String bauthor = request.getParameter("bauthor");
        String bpublish= request.getParameter("bpublish");
        String bisbn = request.getParameter("bisbn");
        String bcount = request.getParameter("bcount");
        String blink= request.getParameter("blink");
        String bimg= request.getParameter("bimg");
        String btag = request.getParameter("btag");
        String sql = "select *from book where bid = '"+bid+"'";
        ResultSet rs = conn.getRs(sql);
        try {
            if(rs.next()){
                if(bname.equals(rs.getString("bname")) && bauthor.equals(rs.getString("bauthor")) && bpublish.equals(rs.getString("bpublish")) && bisbn.equals(rs.getString("bisbn"))&&btag.equals(rs.getString("btag"))){
                    String sql1 = "update book set bcount = bcount+1,bleftcount = bleftcount+1 where bid = '"+bid+"'";
                    conn.Excu(sql1);
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong></strong>添加成功. \n" +
                            "</div>");
                    request.getRequestDispatcher("add_book.jsp").forward(request,response);
                }else {
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong>Warning!</strong>信息有误. \n" +
                            "</div>");
                    request.getRequestDispatcher("add_book.jsp").forward(request,response);
                }

            }else {
                String sql2 = "insert into book(bid,bname,bauthor,bpublish,bisbn,bcount,bleftcount,btag,blink,bimg) values('"+bid+"','"+bname+"','"+bauthor+"','"+bpublish+"','"+bisbn+"','"+bcount+"','"+bcount+"','"+btag+"','"+blink+"','"+bimg+"')";
                conn.Excu(sql2);
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong></strong>添加成功. \n" +
                        "</div>");
                request.getRequestDispatcher("add_book.jsp").forward(request,response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
