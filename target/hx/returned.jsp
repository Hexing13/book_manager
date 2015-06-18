<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.hx.book.BookConn" %>
<%@ page import="com.hx.book.limit" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-15
  Time: 下午2:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>图书管理还书系统</title>
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
        if (rs.next()) {
          if (password.equals(rs.getString("spassword")) && verify.equals(rs.getString("verify"))) {
            String sql1 = "select * from borrow where snum = '" +num+ "'";
            ResultSet rs1 = conn.getRs(sql1);
            limit t = new limit();
            while (rs1.next()) {
              if (t.daysBetween(new Date(), rs1.getDate("bdate")) < 0) {
                session.setAttribute("exnum", "");
                session.setAttribute("exnum", session.getAttribute("exnum") + num);
                response.sendRedirect("exceed.jsp");
                return;
              }
            }
            String sql4 = "select snum, bid from borrow where snum = '"+num+"'";
            ResultSet rs4 = conn.getRs(sql4);
            while (rs4.next()){
              if(num.equals(rs4.getString("snum")) && bid == rs4.getInt("bid")){
                String sql2 = "update book set bleftcount = bleftcount+1 where bid = '"+bid+"'";
                String sql3 = "delete from borrow where bid = '"+bid+"' and snum = '"+num+"'";
                conn.Excu(sql2);
                conn.Excu(sql3);
                request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                        "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                        "  <strong>Warning!</strong>还书成功.\n" +
                        "</div>");
                request.getRequestDispatcher("return.jsp").forward(request,response);
              }
            }
            request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                    "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                    "  <strong>Warning!</strong>没有相关借阅信息.\n" +
                    "</div>");
            request.getRequestDispatcher("return.jsp").forward(request,response);
          } else{
            request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                    "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                    "  <strong>Warning!</strong>密码错误或系统管理员未验证.\n" +
                    "</div>");
            request.getRequestDispatcher("return.jsp").forward(request,response);
          }
        }else{
          request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
                  "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
                  "  <strong>Warning!</strong>请先注册.\n" +
                  "</div>");
          request.getRequestDispatcher("return.jsp").forward(request,response);
        }
      }catch (SQLException e) {
        e.printStackTrace();
      }
    %>
  </table>
</body>
</html>

