<%@ page import="com.hx.book.BookConn" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-16
  Time: 下午11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>学生验证</title>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>
<body>
<%
  if(session.getAttribute("flag2")==null){
    response.sendRedirect("m_index.jsp");
  }
%>
<p style="width:100px;height:20px;margin-left:1220px;margin-top: 5px;"><a href="m_logined.jsp">返回主界面</a></p>
<h3 align=center>学生验证</h3>
<form action="<%=request.getContextPath()%>/verify" method="post">
<table class="table table-hover" align="center">
  <th>学号</th><th>姓名</th><th>专业</th><th>班级</th><th>验证</th>
  <%
    BookConn conn = new BookConn();
    //获取查询字段
   String sql = "select *from student where verify = '0'";
    ResultSet rs = conn.getRs(sql);
    while (rs.next()){
      String num = rs.getString("snum");
  %>
  <tr>
    <td><%=rs.getString("snum")%></td>
    <td><%=rs.getString("sname")%></td>
    <td><%=rs.getString("smajor")%></td>
    <td><%=rs.getString("sclass")%></td>
    <td><input type="submit"  name="snum" value="<%=num%>"/></td>
  </tr>
  <%
    }
  %>
      </table>
    </form>
  </body>
</html>