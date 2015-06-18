<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.hx.book.BookConn" %>
<%--
  Created by IntelliJ IDEA.
  User: hexing
  Date: 15-6-10
  Time: 下午7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>查询展示</title>
  <script src="http://code.jquery.com/jquery.min.js"></script>
  <script type="text/javascript" src="js/bootstrap.min.js"></script>
  <style type="text/css"> @import "css/bootstrap.min.css";</style>
</head>
<body>
<h3 align=center>图书显示</h3>
<table class="table table-hover" align="center">
    <th>编号</th><th>书名</th><th>作者</th><th>出版社</th><th>ISBN</th><th>总书数</th><th>剩余数</th><th>查看详情</th>
 <%
    BookConn conn = new BookConn();
  //获取查询字段
    String squery = request.getParameter("squery");
     if(squery.equals("")){

     }else{
         String sql = "select *from book where bname like '%"+squery+"%' or bauthor like '%"+squery+"%' or bid like '%"+squery+"%'";
         ResultSet rs = conn.getRs(sql);
         try {
             while (rs.next()){

 %>
    <tr>
        <td><%=rs.getString("bid")%></td>
        <td><%=rs.getString("bname")%></td>
        <td><%=rs.getString("bauthor")%></td>
        <td><%=rs.getString("bpublish")%></td>
        <td><%=rs.getString("bisbn")%></td>
        <td><%=rs.getString("bcount")%></td>
        <td><%=rs.getString("bleftcount")%></td>
        <td><a href="<%=rs.getString("blink")%>">豆瓣详情</a></td>
    </tr>
    <%
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        }
    %>

</table>
</body>
</html>
