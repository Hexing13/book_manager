<%@ page import="com.hx.book.BookConn" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.hx.book.limit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-15
  Time: 下午3:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>图书馆续借系统</title>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>
<body>
<%
    if(session.getAttribute("flag")==null){
        response.sendRedirect("index.jsp");
    }
%>

<p style="width:100px;height:20px;margin-left:1220px;margin-top: 5px;"><a href="logined.jsp">返回主界面</a></p>
<h3 align=center>图书馆续借信息</h3>
<form action="<%=request.getContextPath()%>/renewed" method="post">
<table class="table table-hover" align="center">
  <th>学号</th><th>姓名</th><th>书号</th><th>书名</th><th>截止日期</th><th>续借信息</th>
  <%
    BookConn conn = new BookConn();
    response.setContentType("text/html;charset=UTF-8");
      String sql1 = "select * from borrow where snum = '"+session.getAttribute("num")+"'";
      ResultSet rs1 = conn.getRs(sql1);
      limit t = new limit();
      while (rs1.next()){
          String bid = rs1.getString("bid");
          int valid = rs1.getInt("flag");
          if(t.daysBetween(new Date(),rs1.getDate("bdate")) < 0){
  %>
    <tr>
        <td><%=rs1.getString("snum")%></td>
        <td><%=rs1.getString("sname")%></td>
        <td><%=bid%></td>
        <td><%=rs1.getString("bname")%></td>
        <td><%=rs1.getString("bdate")%></td>
        <td>过期</td>
    </tr>
    <%
        }else if(valid==1){
    %>
    <tr>
        <td><%=rs1.getString("snum")%></td>
        <td><%=rs1.getString("sname")%></td>
        <td><%=rs1.getString("bid")%></td>
        <td><%=rs1.getString("bname")%></td>
        <td><%=rs1.getString("bdate")%></td>
        <td> </td>
    </tr>
    <%
        }else {
    %>
    <tr>
        <td><%=rs1.getString("snum")%></td>
        <td><%=rs1.getString("sname")%></td>
        <td><%=rs1.getString("bid")%></td>
        <td><%=rs1.getString("bname")%></td>
        <td><%=rs1.getString("bdate")%></td>
        <td><input type="submit" name="renew" value="<%=bid%>" /></td>
    </tr>
    <%
            }
        }

    %>
           </table>
        </form>
    </body>
</html>
