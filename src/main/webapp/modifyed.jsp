<%@ page import="com.hx.book.BookConn" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-16
  Time: 下午5:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改信息</title>
</head>
<body>
<%
    if(session.getAttribute("flag")==null){
        response.sendRedirect("index.jsp");
    }
%>
  <%
    BookConn conn = new BookConn();
    response.setContentType("text/html;charset=UTF-8");
    //获取输入信息

    String sname = request.getParameter("sname");
    String smajor = request.getParameter("smajor");
    String sclass = request.getParameter("sclass");
    String spassword = request.getParameter("password1");
    String respassword = request.getParameter("password2");
    if(sname.equals("") || spassword.equals("") || respassword.equals("") || smajor.equals("") || sclass.equals("")){
      request.setAttribute("msg"," <div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
              "        <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
              "        <strong>Warning!</strong>请完善信息.\n" +
              "    </div>");
      request.getRequestDispatcher("modify.jsp").forward(request,response);
      return;
    }
    if(spassword.equals(respassword)){
      String sql = "update  student set sname = '"+sname+"',smajor = '"+smajor+"',sclass='"+sclass+"',spassword = '"+spassword+"' where snum = '"+session.getAttribute("num")+"'";
      conn.Excu(sql);
      request.setAttribute("msg"," <div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
              "        <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
              "        <strong>Warning!</strong>修改成功,重新登陆.\n" +
              "    </div>");
      request.getRequestDispatcher("login.jsp").forward(request,response);
    }else {
      request.setAttribute("msg","<div class=\"alert alert-warning alert-dismissible\" role=\"alert\">\n" +
              "  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>\n" +
              "  <strong>Warning!</strong>密码错误. \n" +
              "</div>");
      request.getRequestDispatcher("modify.jsp").forward(request,response);
    }
  %>
</body>
</html>
