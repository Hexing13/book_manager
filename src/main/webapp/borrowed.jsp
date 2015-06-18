<%@ page import="com.hx.book.BookConn" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.hx.book.limit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-13
  Time: 下午3:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书管理借书系统</title>
</head>
<body>
<%
    if(session.getAttribute("flag1")==null){
        response.sendRedirect("l_index.jsp");
    }
%>
<table class="table table-hover" align="center">
<%
    String num = request.getParameter("snum");
    String password = request.getParameter("spassword");
    String verify = "1";
    int bid = Integer.parseInt(request.getParameter("bid"));
    BookConn conn = new BookConn();
    response.setContentType("text/html;charset=UTF-8");
    String sql = "select * from student where snum = '"+num+"'";
    ResultSet rs = conn.getRs(sql);
    try {
        if(rs.next()) {
            if (password.equals(rs.getString("spassword")) && verify.equals(rs.getString("verify"))) {
                String sql3 = "select count(*)from borrow where snum = '" + num + "'";
                ResultSet rs3 = conn.getRs(sql3);
                if (rs3.next()) {
                    String sql1 = "select * from borrow where snum = '" + num + "'";
                    ResultSet rs1 = conn.getRs(sql1);
                    limit t = new limit();
                    while (rs1.next()) {
                        if (t.daysBetween(new Date(), rs1.getDate("bdate")) < 0) {
                            session.setAttribute("exnum", "");
                            session.setAttribute("exnum", session.getAttribute("exnum") + num);
                            response.sendRedirect("exceed.jsp");
                            return;
                        }
                        if(bid == rs1.getInt("bid")){
                            request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                                    "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                                    "  <strong>请勿重借.</strong> \n" +
                                    "</div>");
                            request.getRequestDispatcher("borrow.jsp").forward(request, response);
                            return;
                        }
                    }
                    int count = Integer.parseInt(rs3.getString(1));
                    if (count >= 2) {
                        request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                                "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                                "  <strong>借书量超过2.</strong> \n" +
                                "</div>");
                        request.getRequestDispatcher("borrow.jsp").forward(request, response);
                        return;
                    }
                }
                String sql4 = "select bleftcount,bname from book where bid = '" + bid + "'";
                ResultSet rs4 = conn.getRs(sql4);
                if (rs4.next()) {
                    if (rs4.getInt("bleftcount") > 0) {
                        Date d = new Date();
                        Date d1 = new Date(d.getTime() + 30 * 24 * 60 * 60 * 1000L);
                        SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd");
                        String sql2 = "insert into borrow(snum,sname,bid,bname,bdate,flag) values('" + num + "','" + rs.getString("sname") + "','" + bid + "','" + rs4.getString("bname") + "','" + f.format(d1) + "',0)";
                        conn.Excu(sql2);
                        String sql5 = "update book set bleftcount = bleftcount-1 where bid = '" + bid + "'";
                        conn.Excu(sql5);
                        request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                                "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                                "  <strong>借书成功.</strong> \n" +
                                "</div>");
                        request.getRequestDispatcher("borrow.jsp").forward(request, response);
                    } else {
                        request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                                "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                                "  <strong>书本已借完.</strong> \n" +
                                "</div>");
                        request.getRequestDispatcher("borrow.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                            "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                            "  <strong>没有相关书籍.</strong> \n" +
                            "</div>");
                    request.getRequestDispatcher("borrow.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong>密码错误或管理员未验证.</strong> \n" +
                        "</div>");
                request.getRequestDispatcher("borrow.jsp").forward(request, response);
            }
        }else {
            request.setAttribute("msg", "<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                    "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                    "  <strong>请先注册.</strong> \n" +
                    "</div>");
            request.getRequestDispatcher("borrow.jsp").forward(request, response);
        }
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
        </table>
  </body>
</html>