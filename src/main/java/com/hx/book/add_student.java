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
@WebServlet(name = "add_student",urlPatterns = {"/add_student"})
public class add_student extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookConn conn = new BookConn();
        response.setContentType("text/html;charset=UTF-8");
        //获取输入信息
        String snum1 = request.getParameter("userid");
        String sname = request.getParameter("sname");
        String smajor = request.getParameter("smajor");
        String sclass = request.getParameter("sclass");
        String spassword = request.getParameter("password1");
        String respassword = request.getParameter("password2");
        if(snum1.equals("") || sname.equals("") || spassword.equals("") || respassword.equals("") || smajor.equals("") || sclass.equals("")){
            request.setAttribute("msg"," <div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                    "        <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                    "        <strong>Warning!</strong>请完善信息.\n" +
                    "    </div>");
            request.getRequestDispatcher("regist.jsp").forward(request,response);
            return;
        }
        String repate_verify = "select *from student where snum = '"+snum1+"'";
        ResultSet rs = conn.getRs(repate_verify);
        try {
            if(rs.next()){
                request.setAttribute("msg"," <div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "        <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "        <strong>Warning!</strong>该学号已被注册.\n" +
                        "    </div>");
                request.getRequestDispatcher("add_student.jsp").forward(request,response);
            }else{
                if(spassword.equals(respassword)){

                    String sql = "insert into student(snum,sname,smajor,sclass,spassword,verify) values('"+snum1+"', '"+sname+"', '"+smajor+"', '"+sclass+"', '"+spassword+"','1')";
                    conn.Excu(sql);
                    response.sendRedirect("mregist_success.jsp");
                }else {
                    request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong>Warning!</strong>密码错误. \n" +
                            "</div>");
                    request.getRequestDispatcher("add_student.jsp").forward(request,response);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
