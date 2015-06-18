<%@ page import="com.hx.book.BookConn" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.hx.book.limit" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-14
  Time: 下午8:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>超期图书信息</title>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>
<body>
<%
  if(session.getAttribute("flag1")==null){
    response.sendRedirect("l_index.jsp");
  }
%>
<p style="width:100px;height:20px;margin-left:1220px;margin-top: 5px;"><a href="l_logined.jsp">返回主界面</a></p>
<h3 align=center>超期图书信息</h3>
<form action="<%=request.getContextPath()%>/exceed" method="post">
<table class="table table-hover" align="center">
  <th>学号</th><th>姓名</th><th>书号</th><th>书名</th><th>截止日期</th><th>超期信息</th><th>罚款金额/元</th><th>确认罚款</th>
  <%
    String num = (String) session.getAttribute("exnum");
    BookConn conn = new BookConn();
    response.setContentType("text/html;charset=UTF-8");
    String sql = "select * from borrow where snum = '"+num+"'";
    ResultSet rs = conn.getRs(sql);
    limit t = new limit();
    while (rs.next()){
      String bid = rs.getString("bid");
      if(t.daysBetween(new Date(),rs.getDate("bdate")) < 0){
        double money = Math.abs(t.daysBetween(new Date(),rs.getDate("bdate")))*0.5;
        if(money > 100){
          money = 100;
        }

  %>
  <tr>
    <td><%=rs.getString("snum")%></td>
    <td><%=rs.getString("sname")%></td>
    <td><%=bid%></td>
    <td><%=rs.getString("bname")%></td>
    <td><%=rs.getString("bdate")%></td>
    <td><span style="color: red">超期</span></td>
    <td><%=money%></td>
    <td><input type="submit"  name="bid" value="<%=bid%>"/></td>
  </tr>
  <%
      }
    }
  %>
</table>
  </form>
</body>
</html>